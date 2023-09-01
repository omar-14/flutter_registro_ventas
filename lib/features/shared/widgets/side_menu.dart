import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intventory/config/router/menu_items.dart';
import 'custom_filled_button.dart';

class SideMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int navDrawerIndex = 3;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

    return NavigationDrawer(
        elevation: 1,
        selectedIndex: navDrawerIndex,
        onDestinationSelected: (value) {
          setState(() {
            navDrawerIndex = value;
          });

          final menuItems = appMenuItems[value];

          context.push(menuItems.link);

          widget.scaffoldKey.currentState?.closeDrawer();
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
            child: Text('Saludos', style: textStyles.titleMedium),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
            child: Text('Tony Stark', style: textStyles.titleSmall),
          ),
          ...appMenuItems.map((menuItem) => NavigationDrawerDestination(
              icon: Icon(menuItem.icon), label: Text(menuItem.title))),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomFilledButton(
                onPressed: () {
                  // ref.read(authProvider.notifier).logout();
                },
                text: 'Cerrar sesión'),
          )
        ]);
  }
}
