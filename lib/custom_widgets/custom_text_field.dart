import 'package:flutter/material.dart';

import '../colors/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final IconButton? iconButton;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    this.validator,
    this.onTap,
    this.readOnly=false,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.iconButton,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        onTap: onTap,
        readOnly: readOnly,
        controller: controller,
        obscureText: obscureText,
        cursorColor: Colors.black,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          suffixIconColor: Colors.black,
          suffixIcon: iconButton,
          alignLabelWithHint: true,
          hintText: labelText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.inactiveDotColor,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColor.inactiveDotColor, width: 2),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
