// Importing necessary packages and resources
import 'package:final_project_blog_app/resources/color_manager.dart';
import 'package:final_project_blog_app/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Define the main application class
class MyApp extends StatelessWidget {
  // Constructor for the MyApp class
  const MyApp({super.key});

  // Build method for the application widget
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // ScreenUtil configuration
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          // Configuration for the MaterialApp
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // Define the theme for the app
            colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.gradientDarkPurpleColor),
            useMaterial3: true,
            fontFamily: "PrimaryFonts",
            cardTheme: const CardTheme(
              surfaceTintColor: ColorManager.whiteColor,
            ),
            scaffoldBackgroundColor: ColorManager.whiteColor,
          ),
          routerConfig: router, // Define the app's router configuration
        );
      },
    );
  }
}