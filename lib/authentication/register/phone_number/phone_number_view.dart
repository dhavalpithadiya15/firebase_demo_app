import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_demo_app/authentication/register/phone_number/phone_number_cubit.dart';
import 'package:firebase_demo_app/authentication/register/phone_number/phone_number_state.dart';
import 'package:firebase_demo_app/authentication/register/phone_number/submit_otp/submit_otp_view.dart';
import 'package:firebase_demo_app/custom_widgets/custom_phone_text_field.dart';
import 'package:firebase_demo_app/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../colors/app_color.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/tittle_text.dart';

class PhoneNumberView extends StatelessWidget {
  const PhoneNumberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double totalHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => PhoneNumberCubit(),
      child: Builder(builder: (context) {
        return BlocListener<PhoneNumberCubit, PhoneNumberState>(
          listener: (context, state) {
            if (state.otpSendSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                RoutesGenerator.submitOtp,
                (route) => route.isActive,
                arguments: {"completeNumber": state.completeNumber, "verificationId": state.verificationId},
              );
            }
          },
          child: Scaffold(
            appBar: AppBar(),
            body: SizedBox(
              width: totalWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TittleText(text: "Mobile Number"),
                  SizedBox(
                    height: totalHeight * 0.06,
                  ),
                  SizedBox(
                    width: totalWidth * 0.7,
                    child: const Text("Confirm the country code and enter your mobile number", textAlign: TextAlign.center),
                  ),
                  SizedBox(
                    height: totalHeight * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "YOUR NUMBER",
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                          ),
                        ),
                        CustomPhoneTextField(
                          onChangeCountryCode: (value) => BlocProvider.of<PhoneNumberCubit>(context)..onChangeCountryCode(value),
                          controller: context.read<PhoneNumberCubit>().state.numberController,
                          onPressedClearField: () =>BlocProvider.of<PhoneNumberCubit>(context)..clearNumber(),
                          formKey: context.read<PhoneNumberCubit>().state.formKey,
                        ),
                        SizedBox(
                          height: totalHeight * 0.05,
                        ),
                        CustomButton(
                          onTap: () async {
                            if (context.read<PhoneNumberCubit>().state.formKey.currentState!.validate()) {
                              await BlocProvider.of<PhoneNumberCubit>(context).showNumberConfirmationDialog(context);
                            }
                          },
                          text: "Next",
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

/*
Row(
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
onChanged: (value) => BlocProvider.of<PhoneNumberCubit>(context)..onChangeCountryCode(value),
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
key: context.read<PhoneNumberCubit>().state.formKey,
child: TextFormField(
validator: (value) {
if (value!.isEmpty) {
return "Please enter number";
} else if (value.length < 10) {
return "Please enter 10 digits number";
}
{
return null;
}
},
keyboardType: TextInputType.number,
controller: context.read<PhoneNumberCubit>().state.numberController,
autocorrect: false,
inputFormatters: [context.read<PhoneNumberCubit>().state.maskTextInputFormatter],
style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
cursorColor: Colors.black,
textAlignVertical: TextAlignVertical.center,
decoration: InputDecoration(
hintText: "99999 99999",
isDense: true,
contentPadding: EdgeInsets.zero,
suffixIcon: IconButton(
onPressed: () => BlocProvider.of<PhoneNumberCubit>(context)..clearNumber(),
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
),*/
