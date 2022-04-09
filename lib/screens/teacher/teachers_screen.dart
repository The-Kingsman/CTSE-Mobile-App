import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teach_rate/models/Teacher.dart';
import 'package:teach_rate/models/User.dart';
import 'package:teach_rate/providers/TeacherProvider.dart';
import 'package:teach_rate/screens/teacher/add_teacher_screen.dart';
import 'package:teach_rate/screens/teacher/view_teacher_screen.dart';
import 'package:teach_rate/widgets/common/app_drawer.dart';
import 'package:teach_rate/widgets/teacher/search_bar.dart';
import 'package:teach_rate/widgets/teacher/teacher_tile.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({Key? key}) : super(key: key);

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isAdmin = false;

  bool loading = false;
  String searchText = '';
  late Timer searchOnStoppedTyping;
  final _controller = ScrollController();

  @override
  initState() {
    checkAdmin();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TeacherProvider>(context, listen: false).fetchTeachers();

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(''),
        elevation: 1.0,
        centerTitle: false,
      ),
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTeacherScreen(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            SearchBar(_updateSearchText, 'teacher'),
            const SizedBox(height: 10),
            Expanded(
              child: Consumer<TeacherProvider>(
                builder: (context, provider, child) => ListView.builder(
                  padding: const EdgeInsets.only(
                      bottom: kFloatingActionButtonMargin + 48),
                  controller: _controller,
                  itemCount: provider.getTeachers().length,
                  itemBuilder: (context, index) => Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      deleteTeacherDialog(provider.getTeachers()[index].id);
                    },
                    direction: DismissDirection.endToStart,
                    background: const Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewTeacherScreen(
                                provider.getTeachers()[index]),
                          ),
                        );
                      },
                      child: TeacherTile(provider.getTeachers()[index]),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    var role = prefs.getString('role');
    if (role.toString() == 'ADMIN') {
      setState(() {
        isAdmin = true;
      });
    }
  }

  deleteTeacherDialog(id) {
    showDialog(
      context: context,
      builder: (ctx) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: AlertDialog(
          elevation: 0.0,
          title: Row(
            children: const [
              Icon(
                Icons.delete,
                size: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text("Delete Teacher"),
            ],
          ),
          content: const Text(
            'Are you sure you want to do this ?',
            style: TextStyle(fontSize: 14),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  setState(() {});
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey[600]),
                )),
            TextButton(
                onPressed: () {
                  deleteTeacher(id);
                },
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ))
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  deleteTeacher(teacherID) async {
    await Provider.of<TeacherProvider>(context, listen: false)
        .deleteTeacher(teacherID)
        .then(
      (result) {
        Navigator.pop(context);
        if (result is String) {
          Fluttertoast.showToast(
            msg: result,
            backgroundColor: Colors.red.shade500,
            toastLength: Toast.LENGTH_SHORT,
          );
        } else {
          Provider.of<TeacherProvider>(context, listen: false).fetchTeachers();
        }
      },
      onError: (message) {
        Navigator.pop(context);
        Fluttertoast.showToast(
          msg: message,
          backgroundColor: Colors.red.shade500,
          toastLength: Toast.LENGTH_SHORT,
        );
      },
    );
  }

  _updateSearchText(value) {
    const duration = Duration(milliseconds: 800);
    if (searchOnStoppedTyping != null) {
      setState(
        () => searchOnStoppedTyping.cancel(),
      );
    }
    setState(
      () => searchOnStoppedTyping = Timer(
        duration,
        () => search(value),
      ),
    );
  }

  search(value) {}
}
