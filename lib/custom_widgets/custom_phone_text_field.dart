import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_demo_app/helper/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../authentication/register/phone_number/phone_number_cubit.dart';
import '../colors/app_color.dart';

class CustomPhoneTextField extends StatelessWidget {
  final Function(CountryCode) onChangeCountryCode;
  final FormFieldValidator? validator;
  final TextEditingController controller;
  final VoidCallback onPressedClearField;
  final GlobalKey<FormState>? formKey;


  const CustomPhoneTextField({
    Key? key,

    required this.onChangeCountryCode,
    this.validator,
    required this.controller,
    required this.onPressedClearField,
    this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              prefixIcon: CountryCodePicker(
                textStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black, fontSize: 18),
                padding: EdgeInsets.zero,
                backgroundColor: Colors.orange,
                showFlag: false,
                hideMainText: false,
                onChanged: onChangeCountryCode,
                initialSelection: 'IN',
                showCountryOnly: true,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.primaryColor, width: 1.5),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColor.primaryColor, width: 1.5),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          flex: 3,
          child: Form(
            key: formKey,
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter number";
                } else if (value.length <= 10) {
                  return "Please enter 10 digits number";
                }
                {
                  return null;
                }
              },
              keyboardType: TextInputType.number,
              controller: controller,
              autocorrect: false,
              inputFormatters: [Helper.maskTextInputFormatter],
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
              cursorColor: Colors.black,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "99999 99999",
                isDense: true,
                contentPadding: EdgeInsets.zero,
                suffixIcon: IconButton(
                  onPressed: onPressedClearField,
                  icon: const Icon(
                    CupertinoIcons.xmark,
                    size: 17,
                    color: AppColor.primaryColor,
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primaryColor, width: 1.5),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primaryColor, width: 1.5),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
