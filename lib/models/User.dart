class User {
  String id;
  String name;
  String email;
  String age;
  String contact;
  String password;
  String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.contact,
    required this.password,
    required this.role,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        name = json['name'],
        email = json['email'],
        age = json['age'],
        contact = json['contact'],
        password = json['password'],
        role = json['role'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'age': age,
        'contact': contact,
        'password': password,
        'role': role,
      };

  // factory User.fromJson(Map<String, dynamic> json) => User(
  //       id: json['_id'],
  //       name: json['name'],
  //       email: json['email'],
  //       age: json['age'],
  //       contact: json['contact'],
  //       password: json['password'],
  //       role: json['role'],
  //     );
}
