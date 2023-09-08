import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// custom Avatar to list the skills , achievements and project
class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:15.0,vertical: 10),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }
}
