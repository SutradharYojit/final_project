import 'package:go_router/go_router.dart';
import '../view/view.dart';
import 'routes_name.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutesName.splashScreen,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
        path: RoutesName.loginScreen,
        builder: (context, state) {
          return const LoginScreen();
        },
        routes: [
          GoRoute(
            name: RoutesName.signupName,
            path: RoutesName.signupScreen,
            builder: (context, state) {
              return const SignUpScreen();
            },
          ),
        ]),
    GoRoute(
      path: RoutesName.dashboardScreen,
      builder: (context, state) {
        return DashBoardScreen();
      },
    )
  ],
);
