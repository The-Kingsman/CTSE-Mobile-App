import 'dart:async';

import 'package:flutter/material.dart';
import 'package:teach_rate/models/Class.dart';
import 'package:teach_rate/screens/class/add_class_screen.dart';
import 'package:teach_rate/screens/class/edit_class_screen.dart';
import 'package:teach_rate/screens/class/view_class_screen.dart';
import 'package:teach_rate/widgets/class/class_tile.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: GestureDetector(
          onTap: () {},
          child: const Icon(
            Icons.notes,
            color: Colors.black,
            size: 30,
          ),
        ),
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
              builder: (context) => const AddClassScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          children: [
            SearchBar(_updateSearchText, 'class'),
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
                      child: classes.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) => Divider(
                                thickness: 1,
                                color: Colors.grey[300],
                              ),
                              padding: const EdgeInsets.only(
                                  bottom: kFloatingActionButtonMargin + 48),
                              controller: _controller,
                              itemCount: classes.length,
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
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ViewClassScreen(classes[index]),
                                      ),
                                    );
                                  },
                                  child: ClassTile(classes[index]),
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: const Center(
                                  child: Text('No matching teachers found'),
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
