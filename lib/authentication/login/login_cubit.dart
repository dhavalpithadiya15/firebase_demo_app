import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/helper/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import './login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState(emailController: TextEditingController(), passwordController: TextEditingController()));

  void changeShowPassword() {
    bool temp = state.showPassword;
    emit(state.copyWith(showPassword: !temp));
    print(temp);
  }

  Future<void> onLoginSubmit(BuildContext context) async {

    if(state.emailController.text.isNotEmpty&& state.passwordController.text.isNotEmpty){
      EasyLoading.show();
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: state.emailController.text,
          password: state.passwordController.text,
        );

        EasyLoading.dismiss();
        bool temp = state.isUserLoginSuccess;
        temp = true;
        emit(state.copyWith(isUserLoginSuccess: temp));
        print(state.isUserLoginSuccess);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Oops! User not found")));
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wrong Password")));
          print('Wrong password provided for that user.');
        }
        if (e.code == 'invalid-email') {
          EasyLoading.dismiss();
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter valid email address")));
        }
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter email or password")));
    }

  }

  Future<void> signInWithGoogle() async {
    EasyLoading.show();
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final user = await FirebaseAuth.instance.signInWithCredential(credential);
        await Helper.addUserDataToFireStore(user);
        EasyLoading.dismiss();
        bool temp = state.isUserLoginSuccess;
        temp = true;
        emit(state.copyWith(isUserLoginSuccess: temp));
      } else {
        EasyLoading.dismiss();
        print("NULL GOGGLE USER");
      }
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      print(e.code);
    }
  }
}
