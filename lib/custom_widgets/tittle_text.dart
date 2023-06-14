import 'package:flutter/material.dart';

import '../colors/app_color.dart';

class TittleText extends StatelessWidget {
  final String text;

  const TittleText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(  color: AppColor.secondaryColor, fontWeight: FontWeight.w600, fontSize: 20),
    );
  }
}
