import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../helper/helper.dart';
import 'email_password_state.dart';

class EmailPasswordCubit extends Cubit<EmailPasswordState> {
  EmailPasswordCubit()
      : super(
          EmailPasswordState(
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
          ),
        );

  void changeShowPassword() {
    bool temp = state.showPassword;
    emit(state.copyWith(showPassword: !temp));
  }

  Future<void> onEmailPasswordSubmit(BuildContext context) async {

    if(state.emailController.text.isNotEmpty && state.passwordController.text.isNotEmpty){
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: state.emailController.text, password: state.passwordController.text,);
        await Helper.addUserDataToFireStore(credential);
        bool temp = state.isUserRegisteredSuccess;
        temp = true;
        emit(state.copyWith(isUserRegisteredSuccess: temp));
      } on FirebaseAuthException catch (e) {
        print("ERROR $e");
        if (e.code == 'invalid-email') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter valid email address")));
        } else if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("The password provided is too weak")));
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("The account already exists for that email")));
          print('The account already exists for that email.');
        }
      } catch (e) {
        print("ERROR IN EMAIL PASSWORD SUBMISSION $e");
      }
    }else{

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter email or password")));

    }


  }
}
