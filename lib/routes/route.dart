import 'package:go_router/go_router.dart';
import '../model/model.dart';
import '../view/view.dart';
import 'routes_name.dart';
// Defines the app Screen Routing or List of Routes
GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: RoutesName.splashScreen,
      builder: (context, state) {
        return const SplashScreen();
      },
    ),
    // its Routes defines to reduce the stack of screen in login and signup screen
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
        return const DashBoardScreen();
      },
    ),
    GoRoute(
      path: RoutesName.blogDetailsScreen,
      builder: (context, state) {
        return BlogDetailsScreen(
          blogData: state.extra as BlogDataModel,
        );
      },
    ),
    GoRoute(
      path: RoutesName.contactUsScreen,
      builder: (context, state) {
        return const ContactFormScreen();
      },
    ),
    GoRoute(
      path: RoutesName.bloggerProfileScreen,
      builder: (context, state) {
        return BloggerProfileScreen(
          profileData: state.extra as BloggerProfileData,
        );
      },
    ),
    GoRoute(
      path: RoutesName.addBlogScreen,
      builder: (context, state) {
        return AddBlogScreen(
          blogPreference: state.extra as BlogPreferences,
        );
      },
    ),
  ],
);
