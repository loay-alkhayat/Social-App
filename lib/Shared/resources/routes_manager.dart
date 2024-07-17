import 'package:flutter/material.dart';
import 'package:social_app/presentation/edit_profile/edit_profile_screen.dart';

import '../../layout/Main/layout_screen.dart';
import '../../presentation/Create_Post/create_post.dart';
import '../../presentation/Login/login_screen.dart';
import '../../presentation/SignUp/signup_screen.dart';
import '../../presentation/Splash/splash_screen.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/feed_layout";
  static const String feed = "/feed_layout";
  static const String addPostRoute = "/addpost";
  static const String editProfile = "/edit_profile";
  static const String chatDetails = "/chat_details";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case Routes.mainRoute:
        return MaterialPageRoute(
          builder: (context) => const MainLayoutScreen(),
        );

      case Routes.editProfile:
        return MaterialPageRoute(
          builder: (context) => EditProfileScreen(),
        );
      case Routes.addPostRoute:
        return MaterialPageRoute(
          builder: (context) => const AddPostScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (context) => const SignUpScreen(),
        );

      default:
        return UnDefinedRoute();
    }
  }

  static Route<dynamic> UnDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
          appBar: AppBar(title: Text("No Route Founded")),
          body: Center(child: Text("NotFound..!"))),
    );
  }
}
