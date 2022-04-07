class Teacher {
  Teacher({
    required this.name,
    required this.age,
    required this.gender,
    required this.experience,
    required this.fieldofstudy,
    required this.eduQualification,
    required this.about,
  });
  String name;
  int age;
  String gender;
  String experience;
  String fieldofstudy;
  int eduQualification;
  String about;
  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        name: json['name'],
        age: json['age'],
        gender: json['gender'],
        experience: json['experience'],
        fieldofstudy: json['fieldofstudy'],
        eduQualification: json['eduQualification'],
        about: json['about'],
      );
}
