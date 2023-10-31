import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intventory/features/sales/presentation/widgets/widgets.dart';
import 'package:intventory/features/shared/shared.dart';
import 'package:intventory/features/users/presentation/providers/users_provider.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text("Usuarios"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push("/users/new");
        },
        label: const Text("Crear Usuario"),
        icon: const Icon(Icons.person_pin_outlined),
      ),
      body: const _ListUsers(),
    );
  }
}

class _ListUsers extends ConsumerStatefulWidget {
  const _ListUsers();

  @override
  _ListUsersState createState() => _ListUsersState();
}

class _ListUsersState extends ConsumerState<_ListUsers> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if ((scrollController.position.pixels + 100) <=
          scrollController.position.maxScrollExtent) {
        // ref.watch(usersProvider.notifier).loadNextPage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<bool> showDialogOfConfirmation(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CustomDialog(
          title: "Confirmación de Eliminación",
          content: "¿Estás seguro de que deseas eliminar este Producto?",
          hasCancel: true,
        );
      },
    );
  }

  Future<void> onRefresh() async {
    setState(() {});
    await Future.delayed(const Duration(seconds: 2));

    ref.watch(usersProvider.notifier).refreshPage();
  }

  @override
  Widget build(BuildContext context) {
    final usersState = ref.watch(usersProvider);

    const titileStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 18);
    const nameStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 17);
    const textStyle = TextStyle(fontSize: 14);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: usersState.users.length + 1,
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < usersState.users.length) {
              final user = usersState.users[index];

              return Dismissible(
                key: Key(usersState.users[index].id),
                direction: DismissDirection.startToEnd,
                background: Container(
                  color: Colors.green,
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.check, color: Colors.transparent),
                ),
                confirmDismiss: (DismissDirection direction) async {
                  final isDelete = await showDialogOfConfirmation(context);

                  if (!isDelete) {
                    return isDelete;
                  }

                  return await ref
                      .read(usersProvider.notifier)
                      .deleteUser(user.id);
                },
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Producto eliminado.'),
                    ));
                  }
                },
                child: Card(
                  child: ListTile(
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      context.push("/users/${user.id}");
                    },
                    title: Text(
                      "${user.fistName} ${user.lastName}",
                      style: titileStyle,
                    ),
                    subtitle: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "username: ",
                              style: nameStyle,
                            ),
                            Text(
                              user.username,
                              style: textStyle,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              "Rol: ",
                              style: nameStyle,
                            ),
                            Text(
                              user.role,
                              style: textStyle,
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "Email: ",
                              style: nameStyle,
                            ),
                            Text(
                              user.email,
                              style: textStyle,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              // Elemento de relleno que actúa como espacio en blanco
              return const SizedBox(
                  height: 400.0); // Ajusta la altura según tus necesidades
            }
          },
        ),
      ),
    );
  }
}
