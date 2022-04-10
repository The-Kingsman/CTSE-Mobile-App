import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:teach_rate/models/Class.dart';
import 'package:teach_rate/providers/ClassProvider.dart';
import 'package:teach_rate/screens/class/add_class_screen.dart';
import 'package:teach_rate/screens/class/view_class_screen.dart';
import 'package:teach_rate/widgets/class/class_tile.dart';
import 'package:teach_rate/widgets/common/app_drawer.dart';
import 'package:teach_rate/widgets/teacher/search_bar.dart';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({Key? key}) : super(key: key);

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Class> classes = [];
  bool loading = false;
  String searchText = '';
  late Timer searchOnStoppedTyping;
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ClassProvider>(context, listen: false).fetchClasses();
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(''),
        elevation: 1.0,
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddClassScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            SearchBar(_updateSearchText, 'class'),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Consumer<ClassProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.getClasses().length,
                    itemBuilder: (ctx, index) {
                      return Dismissible(
                        background: const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                            size: 40,
                          ),
                        ),
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          deleteClassDialog(provider.getClasses()[index].id);
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewClassScreen(
                                    provider.getClasses()[index]),
                              ),
                            );
                          },
                          child: ClassTile(
                            provider.getClasses()[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  deleteClassDialog(id) {
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
              Text("Delete Class"),
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
                  deleteClass(id);
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

  deleteClass(id) async {
    await Provider.of<ClassProvider>(context, listen: false)
        .deleteClass(id)
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
          Provider.of<ClassProvider>(context, listen: false).fetchClasses();
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
