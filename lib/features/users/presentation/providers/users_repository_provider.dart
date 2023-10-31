import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/auth/presentation/providers/providers.dart';
import 'package:intventory/features/users/domain/domain.dart';
import 'package:intventory/features/users/infrastructure/datasources/user_datasorce_impl.dart';
import 'package:intventory/features/users/infrastructure/repositories/user_repository_impl.dart';

final usersRepositoryProvider = Provider<UserRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final userRepository =
      UserRepositoryImpl(UserDatasorceImpl(accessToken: accessToken));

  return userRepository;
});
