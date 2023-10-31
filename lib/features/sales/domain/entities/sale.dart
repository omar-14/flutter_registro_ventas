import 'package:intventory/features/users/domain/entities/user.dart';

class Sale {
  String id;
  bool isCompleted;
  String userId;
  double total;
  double numberOfProducts;
  DateTime? createdAt;
  User? user;

  Sale({
    required this.id,
    required this.isCompleted,
    required this.userId,
    this.user,
    required this.total,
    required this.numberOfProducts,
    this.createdAt,
  });
}
