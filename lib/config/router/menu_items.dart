import 'package:flutter/material.dart' show IconData, Icons;

class MenuItem {
  final String title;
  final String subtitle;
  final String link;
  final IconData icon;

  const MenuItem(
      {required this.title,
      required this.subtitle,
      required this.link,
      required this.icon});
}

const appMenuItems = <MenuItem>[
  MenuItem(
      title: "Dahsboard",
      subtitle: "Vista de graficas",
      link: "/",
      icon: Icons.home_outlined),
  MenuItem(
      title: "Ventas",
      subtitle: "Vista de ventas",
      link: "/sales",
      icon: Icons.shopping_cart_outlined),
  MenuItem(
      title: "Lista de recomendaciones",
      subtitle: "Vista de recomendaciones",
      link: "/recommendations",
      icon: Icons.credit_card),
  MenuItem(
      title: "Inventario",
      subtitle: "Vista de inventario",
      link: "/intventory",
      icon: Icons.inventory_2_outlined),
  MenuItem(
      title: "Usuarios",
      subtitle: "Vista de usuarios",
      link: "/users",
      icon: Icons.people_outline),
  MenuItem(
      title: "Configuraciones",
      subtitle: "Vista de configuraciones",
      link: "/configs",
      icon: Icons.settings)
];
