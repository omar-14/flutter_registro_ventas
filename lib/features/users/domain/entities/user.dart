// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  String username;
  String fistName;
  String lastName;
  String id;
  String role;
  String email;
  String? password;

  User({
    required this.username,
    required this.fistName,
    required this.lastName,
    required this.id,
    required this.role,
    required this.email,
    this.password,
  });
}
