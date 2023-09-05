import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key, required this.widget, required this.length});

  final Widget widget;
  final int length;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return widget;
      },
    );
  }
}
