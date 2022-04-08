import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teach_rate/models/Teacher.dart';
import 'package:teach_rate/screens/teacher/add_teacher_screen.dart';
import 'package:teach_rate/widgets/teacher/search_bar.dart';
import 'package:teach_rate/widgets/teacher/teacher_tile.dart';

class TeachersScreen extends StatefulWidget {
  const TeachersScreen({Key? key}) : super(key: key);

  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

class _TeachersScreenState extends State<TeachersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late List<Teacher> teachers;
  late bool loading;
  late String searchText;
  late Timer searchOnStoppedTyping;
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTeacherScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            SearchBar(_updateSearchText, 'project'),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {},
                      child: teachers.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) => Divider(
                                thickness: 1,
                                color: Colors.grey[300],
                              ),
                              padding: const EdgeInsets.only(
                                  bottom: kFloatingActionButtonMargin + 48),
                              controller: _controller,
                              itemCount: teachers.length,
                              itemBuilder: (context, index) => Dismissible(
                                key: UniqueKey(),
                                onDismissed: (direction) {},
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
                                  onTap: () {},
                                  child: TeacherTile(teachers[index]),
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: const Center(
                                  child: Text('No matching projects found'),
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
