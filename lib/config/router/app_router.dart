import 'package:go_router/go_router.dart';
import 'package:intventory/features/configurations/presentations/screens/configurations_screen.dart';
import 'package:intventory/features/home/presentation/screens/home_screen.dart';
import 'package:intventory/features/inventory/presentation/screens/inventory_screen.dart';
import 'package:intventory/features/recommendations/presentations/screens/recommendations_screen.dart';
import 'package:intventory/features/sales/presentation/screens/shales_screen.dart';
import 'package:intventory/features/users/presentation/screens/users_screen.dart';

final appRouter = GoRouter(initialLocation: "/intventory", routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: "/sales",
    builder: (context, state) => const SalesScreen(),
  ),
  GoRoute(
    path: "/recommendations",
    builder: (context, state) => const RecommendationsScreen(),
  ),
  GoRoute(
    path: "/intventory",
    builder: (context, state) => const InventoryScreen(),
  ),
  GoRoute(
    path: "/users",
    builder: (context, state) => const UsersScreen(),
  ),
  GoRoute(
    path: "/configs",
    builder: (context, state) => const ConfigurationsScreen(),
  ),
]);
