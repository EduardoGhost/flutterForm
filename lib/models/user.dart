
class User {
  final String id;
  final String name;
  final String email;
  final String avatarUrl;
  final int age;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.age,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'age' : age,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      avatarUrl: map['avatarUrl'],
      age: map['age'],
    );
  }
}