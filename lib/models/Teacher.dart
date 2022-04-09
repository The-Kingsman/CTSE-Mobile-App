class Teacher {
  String id;
  String name;
  String email;
  String age;
  String contact;
  String experience;
  String fieldofstudy;
  String eduQualification;
  String about;

  Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.contact,
    required this.experience,
    required this.fieldofstudy,
    required this.eduQualification,
    required this.about,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        age: json['age'],
        contact: json['contact'],
        experience: json['experience'],
        fieldofstudy: json['fieldofstudy'],
        eduQualification: json['eduQualification'],
        about: json['about'],
      );
}
