import 'package:final_project_blog_app/resources/color_manager.dart';
import 'package:final_project_blog_app/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: ColorManager.gradientDarkPurpleColor),
            useMaterial3: true,
            fontFamily: "PrimaryFonts",
            cardTheme: const CardTheme(
              surfaceTintColor: ColorManager.whiteColor,
            ),
            scaffoldBackgroundColor: ColorManager.whiteColor
          ),
          routerConfig: router,
        );
      },
    );
  }
}
