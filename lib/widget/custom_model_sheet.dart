import 'package:flutter/material.dart';

import '../resources/resources.dart';

Future<dynamic> buildShowModalBottomSheet(BuildContext context, {required Widget widget}) {
  return showModalBottomSheet(
    useSafeArea: true,
    backgroundColor: ColorManager.whiteColor,
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      return FractionallySizedBox(
        heightFactor: 0.7,
        child: widget,
      );
    },
  );
}