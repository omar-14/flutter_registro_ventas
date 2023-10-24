// import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

import 'package:intventory/features/shared/shared.dart';
import 'package:intventory/features/users/domain/domain.dart';
import '../users_provider.dart';

final userFormProvider = StateNotifierProvider.autoDispose
    .family<UserFormNotifier, UserFormState, User>((ref, user) {
  final creareCallback = ref.watch(usersProvider.notifier).createUser;
  final updateCallback = ref.watch(usersProvider.notifier).updateUser;

  return UserFormNotifier(
      user: user,
      onSubmitCreateCallback: creareCallback,
      onSubmitUpdateCallback: updateCallback);
});

class UserFormNotifier extends StateNotifier<UserFormState> {
  final Future Function(Map<String, String> userLike)? onSubmitCreateCallback;
  final Future Function(Map<String, String> userLike, String id)?
      onSubmitUpdateCallback;

  UserFormNotifier(
      {this.onSubmitCreateCallback,
      this.onSubmitUpdateCallback,
      required User user})
      : super(UserFormState(
          id: user.id,
          firstName: Name.dirty(user.fistName),
          lastName: LastName.dirty(user.lastName),
          username: Username.dirty(user.username),
          email: Email.dirty(user.email),
          password: Password.dirty(user.password ?? ""),
          role: user.role,
        ));

  Future<bool> onFormSubmit() async {
    _touchEverything();

    if (!state.isFormValid) return false;

    if (onSubmitCreateCallback == null && onSubmitUpdateCallback == null) {
      return false;
    }

    final userLike = {
      'first_name': state.firstName.value,
      'last_name': state.lastName.value,
      'username': state.username.value,
      'password': state.password.value,
      'role': state.role,
      'email': state.email.value,
    };

    if (!state.id!.contains("new")) {
      try {
        return await onSubmitUpdateCallback!(userLike, state.id!);
      } catch (e) {
        return false;
      }
    }

    try {
      return await onSubmitCreateCallback!(userLike);
    } catch (e) {
      return false;
    }
  }

  void _touchEverything() {
    state = state.copyWith(
        isFormValid: Formz.validate([
      Name.dirty(state.firstName.value),
      LastName.dirty(state.lastName.value),
      Username.dirty(state.username.value),
      Email.dirty(state.email.value),
      Password.dirty(state.password.value)
    ]));
  }

  void onFirtsNameChanged(String value) {
    state = state.copyWith(
        firstName: Name.dirty(value),
        isFormValid: Formz.validate([
          Name.dirty(value),
          LastName.dirty(state.lastName.value),
          Username.dirty(state.username.value),
          Email.dirty(state.email.value),
          Password.dirty(state.password.value)
        ]));
  }

  void onLastNameChanged(String value) {
    state = state.copyWith(
        lastName: LastName.dirty(value),
        isFormValid: Formz.validate([
          LastName.dirty(value),
          Name.dirty(state.firstName.value),
          Username.dirty(state.username.value),
          Email.dirty(state.email.value),
          Password.dirty(state.password.value)
        ]));
  }

  void onUsernameChanged(String value) {
    state = state.copyWith(
        username: Username.dirty(value),
        isFormValid: Formz.validate([
          Name.dirty(state.firstName.value),
          LastName.dirty(state.lastName.value),
          Username.dirty(value),
          Email.dirty(state.email.value),
          Password.dirty(state.password.value)
        ]));
  }

  void onEmailChanged(String value) {
    state = state.copyWith(
        email: Email.dirty(value),
        isFormValid: Formz.validate([
          Name.dirty(state.firstName.value),
          LastName.dirty(state.lastName.value),
          Username.dirty(state.username.value),
          Email.dirty(value),
          Password.dirty(state.password.value)
        ]));
  }

  void onPasswordChanged(String value) {
    state = state.copyWith(
        password: Password.dirty(value),
        isFormValid: Formz.validate([
          Name.dirty(state.firstName.value),
          LastName.dirty(state.lastName.value),
          Username.dirty(state.username.value),
          Email.dirty(state.email.value),
          Password.dirty(value)
        ]));
  }

  void onRoleChanged(String role) {
    state = state.copyWith(role: role);
  }
}

class UserFormState {
  final bool isFormValid;
  final String? id;
  final Name firstName;
  final LastName lastName;
  final Username username;
  final Email email;
  final Password password;
  final String role;

  UserFormState({
    this.isFormValid = false,
    this.id,
    this.firstName = const Name.dirty(""),
    this.lastName = const LastName.dirty(""),
    this.username = const Username.dirty(""),
    this.email = const Email.dirty(""),
    this.password = const Password.dirty(""),
    this.role = "",
  });

  UserFormState copyWith({
    bool? isFormValid,
    String? id,
    Name? firstName,
    LastName? lastName,
    Username? username,
    Email? email,
    Password? password,
    String? role,
  }) =>
      UserFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
        role: role ?? this.role,
      );
}
