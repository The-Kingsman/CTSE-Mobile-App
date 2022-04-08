import 'package:flutter/material.dart';
import 'package:teach_rate/models/Teacher.dart';

class TeacherTile extends StatelessWidget {
  final Teacher teacher;

  const TeacherTile(this.teacher);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            teacher.name,
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
