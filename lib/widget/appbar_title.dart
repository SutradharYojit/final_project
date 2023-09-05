

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/resources.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.title
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          ImageAssets.projectLogo,
          height: 33.h,
        ),
        Padding(
          padding: EdgeInsets.only(left: 8.0.r),
          child: Text(
            title,
          ),
        ),
      ],
    );
  }
}
