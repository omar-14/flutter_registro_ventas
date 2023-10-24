import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intventory/features/sales/presentation/widgets/widgets.dart';
import 'package:intventory/features/shared/widgets/widgets.dart';
import 'package:intventory/features/users/domain/domain.dart';
import 'package:intventory/features/users/presentation/providers/form/user_form_provider.dart';
import 'package:intventory/features/users/presentation/providers/user_provider.dart';

class UserScreen extends ConsumerWidget {
  final String idUser;
  const UserScreen({super.key, required this.idUser});

  void showSnackbar(BuildContext context, {bool isCreated = false}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(isCreated ? "Usuario Creado" : "Usuario Actualizado")));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(userProvider(idUser));

    return Scaffold(
        appBar: AppBar(
          title: Text("${idUser.contains("new") ? "Nuevo" : "Editar"} Usuario"),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (userState.user == null) return;

            ref
                .read(userFormProvider(userState.user!).notifier)
                .onFormSubmit()
                .then((value) {
              if (!value) return;
              FocusScope.of(context).unfocus();
              context.pop();
              showSnackbar(context, isCreated: idUser.contains("new"));
            });
          },
          label: const Text("Guardar"),
          icon: const Icon(Icons.save_as_outlined),
        ),
        body: userState.user != null
            ? _RegisterForm(
                user: userState.user!,
              )
            : const CustomProgresIndicator());
  }
}

class _RegisterForm extends ConsumerWidget {
  final User user;
  const _RegisterForm({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userForm = ref.watch(userFormProvider(user));

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 50),
              CustomProductField(
                isTopField: true,
                label: 'Nombre',
                initialValue: userForm.firstName.value,
                onChanged: ref
                    .read(userFormProvider(user).notifier)
                    .onFirtsNameChanged,
                errorMessage: userForm.firstName.errorMessage,
              ),
              CustomProductField(
                label: 'Apellido',
                initialValue: userForm.lastName.value,
                onChanged:
                    ref.read(userFormProvider(user).notifier).onLastNameChanged,
                errorMessage: userForm.lastName.errorMessage,
              ),
              CustomProductField(
                label: 'Username',
                initialValue: userForm.username.value,
                onChanged:
                    ref.read(userFormProvider(user).notifier).onUsernameChanged,
                errorMessage: userForm.username.errorMessage,
              ),
              CustomProductField(
                label: 'Email',
                initialValue: userForm.email.value,
                onChanged:
                    ref.read(userFormProvider(user).notifier).onEmailChanged,
                errorMessage: userForm.email.errorMessage,
              ),
              CustomProductField(
                isBottomField: true,
                label: 'Password',
                initialValue: userForm.password.value,
                onChanged:
                    ref.read(userFormProvider(user).notifier).onPasswordChanged,
                errorMessage: userForm.password.errorMessage,
              ),
              const SizedBox(height: 20),
              _RoleSelector(
                  selectedRole: userForm.role,
                  onRoleChanged:
                      ref.read(userFormProvider(user).notifier).onRoleChanged),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoleSelector extends StatelessWidget {
  final String selectedRole;
  final List<String> roles = const ['admin', 'ventas'];
  final List<IconData> rolesIcons = const [
    Icons.assignment_ind_outlined,
    Icons.person_outline_outlined,
  ];
  final void Function(String selectedRole) onRoleChanged;

  const _RoleSelector(
      {required this.selectedRole, required this.onRoleChanged});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SegmentedButton(
        emptySelectionAllowed: false,
        multiSelectionEnabled: false,
        showSelectedIcon: false,
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
        segments: roles.map((role) {
          return ButtonSegment(
              icon: Icon(rolesIcons[roles.indexOf(role)]),
              value: role,
              label: Text(role, style: const TextStyle(fontSize: 18)));
        }).toList(),
        selected: {selectedRole},
        onSelectionChanged: (newSelection) {
          FocusScope.of(context).unfocus();
          onRoleChanged(newSelection.first);
        },
      ),
    );
  }
}
