import 'dart:developer';
import 'package:final_project_blog_app/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../resources/resources.dart';
import 'package:go_router/go_router.dart';

import '../../services/user_preferences.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final userPreferences = UserPreferences();
  @override
  void initState() {
    super.initState();
    userPreferences.getUserInfo();
    navigation();
  }

  void navigation() {
    Duration duration = const Duration(seconds: 3);
    Future.delayed(
      duration,
      () {
        if (userPreferences.email != null &&
            userPreferences.pass != null &&
            userPreferences.email!.isNotEmpty &&
            userPreferences.pass!.isNotEmpty) {
          context.go(RoutesName.dashboardScreen);
        } else {
          log(userPreferences.email.toString());
          context.go(RoutesName.loginScreen);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(AnimationAssets.splashAnimation),
              Text(
                StringManager.myApp,
                style: TextStyle(
                  fontSize: 55.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: "DancingScript",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
