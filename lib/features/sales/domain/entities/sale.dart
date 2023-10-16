import 'package:intventory/features/auth/domain/domain.dart';

class Sale {
  String id;
  bool isCompleted;
  String userId;
  int total;
  DateTime? createdAt;
  User? user;

  Sale({
    required this.id,
    required this.isCompleted,
    required this.userId,
    this.user,
    required this.total,
    this.createdAt,
  });
}
