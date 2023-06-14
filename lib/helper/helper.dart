import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/modal/user_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:lottie/lottie.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../colors/app_color.dart';

class Helper {
  static final MaskTextInputFormatter maskTextInputFormatter=MaskTextInputFormatter(mask: '##### #####');
  static int pageSelect=0;
  static Future<void> loginSuccessDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        Future.delayed(const Duration(seconds: 3)).then((value) => Navigator.pop(context));
        return CupertinoAlertDialog(
          title: const Text("Login Success"),
          content: Lottie.asset("assets/lottie/login_success.json", height: 100, width: 100),
        );
      },
    );
  }

  static void loadingConfig() {
    EasyLoading.instance
      ..maskColor = Colors.blue
      ..maskType = EasyLoadingMaskType.clear
      ..boxShadow = <BoxShadow>[]
      ..backgroundColor = Colors.transparent
      ..indicatorWidget = const CircularProgressIndicator(
        color: AppColor.primaryColor,
      )
      ..maskType = EasyLoadingMaskType.black
      ..maskColor = Colors.black
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorColor = Colors.blue
      ..textColor = Colors.black;
  }

  static Future<void> addUserDataToFireStore(UserCredential userDetail) async {
    CollectionReference usersTable = FirebaseFirestore.instance.collection('users_data');
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("users_data").get();

    var userExistInFireStore = querySnapshot.docs.map((e) => e.data()).toList().where((element) => element['uid'] == userDetail.user!.uid).toList();
    if (userExistInFireStore.isEmpty) {
      var userData = UserModal(
        email: userDetail.user?.email ?? "",
        name: userDetail.user?.displayName ?? '',
        phoneNumber: userDetail.user?.phoneNumber ?? '',
        uid: userDetail.user?.uid ?? '',
      );
      usersTable.add(userData.toMap());
    } else {
      print("USER EXIST IN FIRE STORE");
    }
  }

  static Future<void> getUsersDetails() async {
    /*  var collection = FirebaseFirestore.instance.collection("users_data");
    var docSnapshot = await collection.doc('aBN5EtdvZQHf40ZeI4uK').get();

    var data = docSnapshot.data();
    print("=========${data}");*/
    var collection = FirebaseFirestore.instance.collection("users_data");
    QuerySnapshot querySnapshot = await collection.get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("===User Data $allData");



  }

}

