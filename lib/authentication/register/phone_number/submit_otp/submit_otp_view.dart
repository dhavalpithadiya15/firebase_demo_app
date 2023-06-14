import 'package:firebase_demo_app/authentication/register/phone_number/submit_otp/submit_otp_cubit.dart';
import 'package:firebase_demo_app/authentication/register/phone_number/submit_otp/submit_otp_state.dart';
import 'package:firebase_demo_app/colors/app_color.dart';
import 'package:firebase_demo_app/custom_widgets/custom_button.dart';
import 'package:firebase_demo_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../custom_widgets/tittle_text.dart';

class SubmitOtpView extends StatelessWidget {
  final String completeNumber;
  final String verificationId;

  const SubmitOtpView({Key? key, required this.completeNumber, required this.verificationId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double totalHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => SubmitOtpCubit(),
      child: Builder(builder: (context) {
        return BlocListener<SubmitOtpCubit, SubmitOtpState>(
          listener: (context, state) {
            if (state.submitOtpSuccess) {
              Navigator.pushReplacementNamed(context, RoutesGenerator.verificationSubmit);
            } else {
              print("ELSE OF SUBIT OTP");
            }
          },
          child: Scaffold(
            appBar: AppBar(),
            body: SizedBox(
              width: totalWidth,
              // color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TittleText(text: "Verification Code"),
                  SizedBox(
                    height: totalHeight * 0.03,
                  ),
                  SizedBox(
                    width: totalWidth * 0.7,
                    child: const Text("Sms verification code has been sent to:", textAlign: TextAlign.center),
                  ),
                  Text(
                    completeNumber,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Pin code",
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                          ),
                        ),
                        PinCodeTextField(
                          pinTheme: PinTheme(
                              activeColor: AppColor.primaryColor, selectedColor: AppColor.primaryColor, inactiveColor: AppColor.primaryColor),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          showCursor: true,
                          autoFocus: true,
                          controller: context.read<SubmitOtpCubit>().state.submitOtpController,
                          length: 6,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          animationDuration: const Duration(milliseconds: 300),
                          appContext: context,
                          onChanged: (value) {
                            print(value);
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CustomButton(
                          onTap: () {
                            BlocProvider.of<SubmitOtpCubit>(context).checkOtp(verificationId, context);
                          },
                          text: 'Next',
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
