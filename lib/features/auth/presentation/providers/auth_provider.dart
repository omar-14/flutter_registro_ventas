import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intventory/features/auth/domain/domain.dart';
import 'package:intventory/features/auth/infrastructure/infrastructure.dart';
import 'package:intventory/features/shared/infrastructure/services/key_value_storage.dart';
import 'package:intventory/features/shared/infrastructure/services/key_value_storage_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRespositoryImpl();
  final keyValueStorageService = KeyValueStorageImpl();

  return AuthNotifier(
      authRepository: authRepository,
      keyValueStorageService: keyValueStorageService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorage keyValueStorageService;

  AuthNotifier(
      {required this.authRepository, required this.keyValueStorageService})
      : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);

      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout("Error no controlado");
    }
  }

  void registerUser(String email, String password, String fullName) async {}

  void checkAuthStatus() async {
    final refresh = await keyValueStorageService.getValue<String>("refresh");

    if (refresh == null) return logout();

    try {
      final user = await authRepository.checkAuthStatus(refresh);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser(User user) async {
    await keyValueStorageService.setKeyValue("token", user.token);
    await keyValueStorageService.setKeyValue("refresh", user.refresh);
    final isAdmin = user.role == "admin";

    state = state.copyWith(
        user: user,
        errorMessage: "",
        authStatus: AuthStatus.authenticated,
        userRole: isAdmin ? AuthRole.admin : AuthRole.ventas);
  }

  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageService.removeKey("token");
    await keyValueStorageService.removeKey("refresh");
    await keyValueStorageService.removeKey("idAdmin");

    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        userRole: AuthRole.checking,
        user: null,
        errorMessage: errorMessage);
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

enum AuthRole { checking, admin, ventas }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;
  final AuthRole? userRole;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = "",
      this.userRole = AuthRole.checking});

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
    AuthRole? userRole,
  }) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage,
          userRole: userRole ?? this.userRole);
}
