class Class {
  String id;
  String teacherID;
  String subject;
  String grade;
  String time;
  String location;
  String fee;
  String day;
  String description;

  Class({
    required this.id,
    required this.teacherID,
    required this.subject,
    required this.grade,
    required this.time,
    required this.location,
    required this.fee,
    required this.day,
    required this.description,
  });
  factory Class.fromJson(Map<String, dynamic> json) => Class(
        id: json['_id'],
        teacherID: json['teacher_id'],
        subject: json['subject'],
        grade: json['grade'],
        time: json['time'],
        location: json['location'],
        fee: json['fee'],
        day: json['day'],
        description: json['description'],
      );
}
