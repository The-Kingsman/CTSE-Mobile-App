import 'package:flutter/material.dart';
import 'package:teach_rate/models/Class.dart';
import 'package:teach_rate/screens/class/edit_class_screen.dart';

class ViewClassScreen extends StatelessWidget {
  final Class _class;
  const ViewClassScreen(this._class);

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
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditClassScreen(_class),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Center(
                child: Icon(Icons.edit),
              ),
            ),
          ),
        ],
        elevation: 1.0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'View Class',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                Table(
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      width: 2,
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid,
                    ),
                    bottom: BorderSide(
                      width: 2,
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid,
                    ),
                  ),
                  columnWidths: const {
                    0: FractionColumnWidth(0.6),
                    1: FractionColumnWidth(0.3)
                  },
                  children: [
                    TableRow(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            'Sample',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Sample',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
