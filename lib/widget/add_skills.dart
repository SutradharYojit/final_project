import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


// this function used in blogger profile screen to add skill, Achievement and project,(user to open bottom sheet)
class AddSkills extends StatelessWidget {
  const AddSkills({
    super.key,
    this.onPressed,
    required this.text,
    required this.visible,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            text,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
        ),
        Visibility(visible: visible, child: IconButton.filledTonal(onPressed: onPressed, icon: const Icon(Icons.add)))
      ],
    );
  }
}
