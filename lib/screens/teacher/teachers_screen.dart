import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teach_rate/models/Teacher.dart';
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
  List<Teacher> teachers = [];
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
    return Consumer<TeacherProvider>(
      builder: (context, value, child) => Scaffold(
        drawer: const AppDrawer(),
        appBar: AppBar(
          title: const Text(''),
          elevation: 1.0,
          centerTitle: false,
        ),
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
              SearchBar(_updateSearchText, 'teacher'),
              const SizedBox(
                height: 10,
              ),
              // Expanded(
              //     child: Consumer<TeacherProvider>(
              //   builder: (_, teacher, __) => ListView.separated(
              //     separatorBuilder: (BuildContext context, int index) =>
              //         Divider(thickness: 1, color: Colors.grey[300]),
              //     padding: const EdgeInsets.only(
              //         bottom: kFloatingActionButtonMargin + 48),
              //     controller: _controller,
              //     itemCount: teacher.getTeachers().length,
              //     itemBuilder: (context, index) => Dismissible(
              //       key: UniqueKey(),
              //       onDismissed: (direction) {},
              //       direction: DismissDirection.endToStart,
              //       background: const Align(
              //         alignment: Alignment.centerRight,
              //         child: Icon(
              //           Icons.delete,
              //           color: Colors.red,
              //           size: 40,
              //         ),
              //       ),
              //       child: GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //               builder: (context) =>
              //                   ViewTeacherScreen(teacher.getTeachers()[index]),
              //             ),
              //           );
              //         },
              //         child: TeacherTile(teacher.getTeachers()[index]),
              //       ),
              //     ),
              //   ),
              // )
              //  SingleChildScrollView(
              //     child: SizedBox(
              //       height: MediaQuery.of(context).size.height,
              //       child: const Center(
              //         child: Text('No matching teachers found'),
              //       ),
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child: Consumer<TeacherProvider>(
              //     builder: (context, teacher, child) => FutureBuilder(
              //       future:
              //           Provider.of<TeacherProvider>(context).fetchTeachers(),
              //       builder: (context, snapshot) {
              //         if (snapshot.connectionState == ConnectionState.waiting) {
              //           return const CircularProgressIndicator();
              //         }
              //         if (!snapshot.hasData) {
              //           return SingleChildScrollView(
              //             child: SizedBox(
              //               height: MediaQuery.of(context).size.height,
              //               child: const Center(
              //                 child: Text('No matching teachers found'),
              //               ),
              //             ),
              //           );
              //         }
              //         if (snapshot.hasData) {
              //           return ListView.separated(
              //             separatorBuilder: (BuildContext context, int index) =>
              //                 Divider(thickness: 1, color: Colors.grey[300]),
              //             padding: const EdgeInsets.only(
              //                 bottom: kFloatingActionButtonMargin + 48),
              //             controller: _controller,
              //             itemCount: teacher.getTeachers().length,
              //             itemBuilder: (context, index) => Dismissible(
              //               key: UniqueKey(),
              //               onDismissed: (direction) {},
              //               direction: DismissDirection.endToStart,
              //               background: const Align(
              //                 alignment: Alignment.centerRight,
              //                 child: Icon(
              //                   Icons.delete,
              //                   color: Colors.red,
              //                   size: 40,
              //                 ),
              //               ),
              //               child: GestureDetector(
              //                 onTap: () {
              //                   Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                       builder: (context) => ViewTeacherScreen(
              //                           teacher.getTeachers()[index]),
              //                     ),
              //                   );
              //                 },
              //                 child: TeacherTile(teacher.getTeachers()[index]),
              //               ),
              //             ),
              //           );
              //         }
              //       },
              //     ),
              //   ),
              // ),
              Consumer<TeacherProvider>(
                builder: (_, teacher, __) => FutureBuilder(
                  future: teacher.fetchTeachers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (!snapshot.hasData) {
                      return SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: const Center(
                            child: Text('No matching teachers found'),
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.separated(
                          itemCount: teacher.getTeachers().length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewTeacherScreen(
                                      teacher.getTeachers()[index]),
                                ),
                              ),
                              child: TeacherTile(teacher.getTeachers()[index]),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            thickness: 2,
                            indent: 20,
                            endIndent: 20,
                          ),
                          physics: const BouncingScrollPhysics(),
                        ),
                      );
                    } else {
                      return const Text(
                        "Somwthing Bad happen",
                        style: TextStyle(
                          backgroundColor: Colors.white,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
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
