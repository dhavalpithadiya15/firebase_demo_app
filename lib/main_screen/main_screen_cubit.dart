import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/custom_widgets/custom_bottom_nav.dart';
import 'package:firebase_demo_app/helper/helper.dart';
import 'package:firebase_demo_app/main_screen/chat/chat_view.dart';
import 'package:firebase_demo_app/main_screen/discovery/discovery_view.dart';
import 'package:firebase_demo_app/main_screen/home/home_view.dart';
import 'package:firebase_demo_app/main_screen/profile/profile_view.dart';
import 'package:firebase_demo_app/modal/user_modal.dart';
import 'package:firebase_demo_app/routes/routes.dart';
import 'package:firebase_demo_app/splash/splash_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../main_screen/main_screen_state.dart';
import '../main_screen/form/form_view.dart';
class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(const MainScreenState()){
    addPages();
    Helper.getUsersDetails();
  }

  Future<void> showLogOutDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Are you sure want to logout ?"),
          actions: [
            CupertinoDialogAction(
              textStyle: const TextStyle(color: Colors.red),
              onPressed: () async {
                await signOutUser(context);
              },
              child: const Text("Logout"),
            ),
            CupertinoDialogAction(
              textStyle: const TextStyle(color: Colors.black),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Future<void> signOutUser(BuildContext context) async {
    EasyLoading.show();
    await FirebaseAuth.instance.signOut().then((value) {
      GoogleSignIn().signOut();
      SplashState.preferences.setBool("loginSuccess", false);
      EasyLoading.dismiss();
      Navigator.pushReplacementNamed(context, RoutesGenerator.login);
    });
  }

  Future<void> displayUsersFromFireStore() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);
    List<UserModal> tempUsersList = List.from(state.usersList);
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("users_data").get();
    EasyLoading.dismiss();
    querySnapshot.docs.map((e) => e.data()).toList().forEach((element) {
      tempUsersList.add(UserModal.fromMap(element));
      emit(state.copyWith(usersList: tempUsersList));
    });
  }

  void pageOnchange(int index) {
    emit(state.copyWith(selectedPage: index));
    print(state.selectedPage);
  }

  void addPages() {
    List<Widget> tempPages = state.pages;
    tempPages=[
      const HomeView(),
      const DiscoveryView(),
      const FormView(),
      const ChatView(),
      const ProfileView(),
    ];
    emit(state.copyWith(pages: tempPages));
  }


  void updateTab(BottomNavigationState navigationState){
    emit(state.copyWith(navigationState: navigationState));
  }
}
