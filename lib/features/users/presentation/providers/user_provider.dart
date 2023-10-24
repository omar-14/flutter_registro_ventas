import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/users/domain/domain.dart';
import 'package:intventory/features/users/presentation/providers/users_repository_provider.dart';

final userProvider =
    StateNotifierProvider.family<UserNotifier, UserState, String>((ref, id) {
  final usersRepository = ref.watch(usersRepositoryProvider);

  return UserNotifier(usersRepository: usersRepository, id: id);
});

class UserNotifier extends StateNotifier<UserState> {
  final UserRepository usersRepository;

  UserNotifier({
    required this.usersRepository,
    required String id,
  }) : super(UserState(id: id)) {
    loadUser();
  }

  Future<User> emptyUser() async {
    return User(
      id: "new",
      username: "",
      fistName: "",
      lastName: "",
      role: "",
      email: "",
      password: "",
    );
  }

  Future<void> loadUser() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    if (state.id.contains("new")) {
      final user = await emptyUser();

      state = state.copyWith(isLoading: false, user: user);
      return;
    }

    final user = await usersRepository.getUserById(state.id);

    state = state.copyWith(isLoading: false, user: user);
  }
}

class UserState {
  final bool isLoading;
  final String id;
  final User? user;

  UserState({required this.id, this.isLoading = false, this.user});

  UserState copyWith({
    bool? isLoading,
    String? id,
    User? user,
  }) =>
      UserState(
        isLoading: isLoading ?? this.isLoading,
        id: id ?? this.id,
        user: user ?? this.user,
      );
}
