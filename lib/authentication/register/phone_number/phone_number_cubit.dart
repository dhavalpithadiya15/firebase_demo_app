import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/authentication/register/phone_number/phone_number_state.dart';
import 'package:firebase_demo_app/helper/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:country_code_picker/country_code_picker.dart';

class PhoneNumberCubit extends Cubit<PhoneNumberState> {
  PhoneNumberCubit()
      : super(
          PhoneNumberState(
              numberController: TextEditingController(),
              formKey: GlobalKey<FormState>()),
        );

  void onChangeCountryCode(CountryCode value) {

    emit(state.copyWith(countryCode: value.dialCode));
    print(state.countryCode);
  }

  void clearNumber() {
    return state.numberController.clear();
  }

  Future<void> showNumberConfirmationDialog(BuildContext context) async {
    print(state.numberController.text);
    String tempFullNumber = "${state.countryCode} ${Helper.maskTextInputFormatter.getUnmaskedText().toString()}";
    print(tempFullNumber);

    emit(state.copyWith(completeNumber: tempFullNumber));
    return await showDialog(
      // barrierColor: AppColor.primaryColor.withOpacity(0.5),
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Phone number confirmation"),
          content: Column(
            children: [
              const Text("We'll send a verification code to the following number"),
              const SizedBox(
                height: 5,
              ),
              Text(
                state.completeNumber,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              textStyle: const TextStyle(color: Colors.green),
              onPressed: () async {
                Navigator.pop(context);
                await sendOtp();
              },
              child: const Text("Confirm"),
            ),
            CupertinoDialogAction(
              textStyle: const TextStyle(color: Colors.red),
              child: const Text("No"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Future<void> sendOtp() async {
    print(state.completeNumber);
    EasyLoading.show();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: state.completeNumber,
      verificationCompleted: (phoneAuthCredential) {
        EasyLoading.dismiss();
        print("VERIFICATION COMPLETED $phoneAuthCredential");
      },
      verificationFailed: (error) {
        EasyLoading.dismiss();
        print("VERIFICATION FAILED $error");

      },
        codeSent: (verificationId, forceResendingToken) {
        EasyLoading.dismiss();
        bool temp = state.otpSendSuccess;
        temp = true;
        String tempVerificationId=verificationId;
        emit(state.copyWith(otpSendSuccess: temp,verificationId: tempVerificationId));
        print("TEMP VERIFICATION ${state.verificationId}");
        print("CODE SENT VERIFICATION ID $verificationId $forceResendingToken");
      },
      codeAutoRetrievalTimeout: (verificationId) {
        EasyLoading.dismiss();
        print("VERIFICATION ID $verificationId");
      },
    );
  }
}
