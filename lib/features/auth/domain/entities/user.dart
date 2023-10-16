class User {
  final String? id;
  final String email;
  final String firstName;
  final String lastName;
  final String username;
  final String role;
  final String token;
  final String refresh;

  User(
      {this.id,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.role,
      required this.email,
      this.token = "",
      this.refresh = ""});

  // bool get isAdmin {
  //   return role == "admin";
  // }
}
