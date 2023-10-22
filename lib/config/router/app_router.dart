import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intventory/features/auth/presentation/screens/screens.dart';
import 'package:intventory/features/auth/presentation/providers/providers.dart';
import 'package:intventory/features/inventory/presentation/screens/screens.dart';
import 'package:intventory/features/sales/presentation/screens/screens.dart';
import 'package:intventory/features/users/presentation/screens/screens.dart';

import 'package:intventory/features/configurations/presentations/screens/configurations_screen.dart';

import 'package:intventory/features/home/presentation/screens/home_screen.dart';
import 'package:intventory/features/shared/widgets/qr_generator.dart';
import 'package:intventory/features/recommendations/presentations/screens/recommendations_screen.dart';

import 'app_router_notifier.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: "/splash",
    refreshListenable: goRouterNotifier,
    routes: [
      GoRoute(
          path: "/splash",
          builder: (context, state) => const CheckAuthStatusScreen()),
      GoRoute(
        path: "/",
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: "/sales",
        builder: (context, state) => const SalesScreen(),
      ),
      GoRoute(
        path: "/sales/:id",
        builder: (context, state) =>
            DetailsSaleScreen(idSale: state.pathParameters["id"] ?? "no-id"),
      ),
      GoRoute(
        path: "/recommendations",
        builder: (context, state) => const RecommendationsScreen(),
      ),
      GoRoute(
        path: "/inventory",
        builder: (context, state) => const InventoryScreen(),
      ),
      GoRoute(
        path: "/qr/:key",
        builder: (context, state) =>
            QRGenerator(keyProduct: state.pathParameters["key"] ?? "no-key"),
      ),
      GoRoute(
        path: "/product/:id",
        builder: (context, state) =>
            ProductScreen(idProduct: state.pathParameters["id"] ?? "no-id"),
      ),
      GoRoute(
        path: "/users",
        builder: (context, state) => const UsersScreen(),
      ),
      GoRoute(
        path: "/configs",
        builder: (context, state) => const ConfigurationsScreen(),
      ),
    ],
    redirect: (context, state) {
      final isGoingTo = state.matchedLocation;

      final authStatus = goRouterNotifier.authStatus;

      if (isGoingTo == "/splash" && authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == "/login" || isGoingTo == "/register") return null;

        return "/login";
      }

      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == "/login" ||
            isGoingTo == "/register" ||
            isGoingTo == "/splash") {
          return "/";
        }
      }

      return null;
    },
  );
});
