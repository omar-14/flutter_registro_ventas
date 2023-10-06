class User {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String username;
  // final String role;
  final String token;
  final String refresh;

  User(
      {required this.id,
      required this.username,
      required this.firstName,
      required this.lastName,
      // required this.role,
      required this.email,
      required this.token,
      required this.refresh});

  // bool get isAdmin {
  //   return role == "admin";
  // }
}
