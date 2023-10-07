// ignore_for_file: public_member_api_docs, sort_constructors_first
class Sale {
  String id;
  bool isCompleted;
  String user;
  int total;
  DateTime createdAt;

  Sale({
    required this.id,
    required this.isCompleted,
    required this.user,
    required this.total,
    required this.createdAt,
  });
}
