class Class {
  Class({
    required this.subject,
    required this.grade,
    required this.time,
    required this.location,
    required this.fee,
    required this.day,
    required this.description,
  });
  String subject;
  int grade;
  DateTime time;
  String location;
  int fee;
  String day;
  String description;
  factory Class.fromJson(Map<String, dynamic> json) => Class(
        subject: json['subject'],
        grade: json['grade'],
        time: json['time'],
        location: json['location'],
        fee: json['fee'],
        day: json['day'],
        description: json['description'],
      );
}
