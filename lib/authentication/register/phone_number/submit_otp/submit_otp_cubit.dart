import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../submit_otp/submit_otp_state.dart';

class SubmitOtpCubit extends Cubit<SubmitOtpState> {
  SubmitOtpCubit() : super(SubmitOtpState(submitOtpController: TextEditingController()));

  Future<void> checkOtp(String verificationId, BuildContext context) async {
    EasyLoading.show();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: state.submitOtpController.text.trim(),
    );
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        await Helper.addUserDataToFireStore(userCredential);
        EasyLoading.dismiss();
        bool temp = state.submitOtpSuccess;
        temp = true;
        emit(state.copyWith(submitOtpSuccess: temp));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter correct code")));
      }
      EasyLoading.dismiss();
      print(e.code);
    }
  }
}
