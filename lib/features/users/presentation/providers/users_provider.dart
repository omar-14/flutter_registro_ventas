import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/users/domain/domain.dart';
import 'package:intventory/features/users/presentation/providers/users_repository_provider.dart';

final usersProvider = StateNotifierProvider<UsersNotifier, UsersState>((ref) {
  final usersRepository = ref.watch(usersRepositoryProvider);

  return UsersNotifier(usersRepository: usersRepository);
});

class UsersNotifier extends StateNotifier<UsersState> {
  final UserRepository usersRepository;

  UsersNotifier({required this.usersRepository}) : super(UsersState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final users = await usersRepository.listUsers(
        limit: state.limit, offset: state.offset);

    if (users.isEmpty) {
      state = state.copyWith(isLoading: false, isLastPage: true);

      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 10,
        users: [...state.users, ...users]);
  }

  Future createUser(Map<String, String> userLike) async {
    if (state.isLoading || state.isLastPage) return;

    final newUser = await usersRepository.createUser(userLike);

    state = state.copyWith(
        isLastPage: false, isLoading: false, users: [...state.users, newUser]);
    return true;
  }

  Future updateUser(Map<String, String> userLike, String idUser) async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final updateUser = await usersRepository.updateUser(userLike, idUser);

    final index = state.users.indexWhere((element) => element.id == idUser);

    state.users[index] = updateUser;

    state = state.copyWith(isLastPage: false, isLoading: false);

    return true;
  }

  Future deleteUser(String idUser) async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final deleteUser = await usersRepository.deleteUser(idUser);

    if (!deleteUser) {
      state = state.copyWith(isLastPage: false, isLoading: false);
      return false;
    }

    state.users.removeWhere((element) => element.id == idUser);
    state = state.copyWith(isLastPage: false, isLoading: false);
    return true;
  }
}

class UsersState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<User> users;

  UsersState(
      {this.isLastPage = false,
      this.limit = 10,
      this.offset = 0,
      this.isLoading = false,
      this.users = const []});

  UsersState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<User>? users,
  }) =>
      UsersState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        users: users ?? this.users,
      );
}
