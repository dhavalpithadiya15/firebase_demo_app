import 'package:firebase_demo_app/custom_widgets/custom_bottom_nav.dart';
import 'package:firebase_demo_app/helper/helper.dart';
import 'package:firebase_demo_app/main_screen/discovery/discovery_view.dart';
import 'package:firebase_demo_app/main_screen/form/form_view.dart';
import 'package:firebase_demo_app/main_screen/home/home_view.dart';
import 'package:firebase_demo_app/main_screen/main_screen_state.dart';
import 'package:firebase_demo_app/main_screen/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../main_screen/main_screen_cubit.dart';

class MainScreenView extends StatelessWidget {
  const MainScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(),
        bottomNavigationBar: const BottomNavBar(),
        appBar: AppBar(
          title: const Text(
            "Home",
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  await BlocProvider.of<MainScreenCubit>(context).showLogOutDialog(context);
                },
                child: const Text(
                  "Log Out",
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
        body: BlocSelector<MainScreenCubit, MainScreenState, BottomNavigationState>(
          selector: (state) => state.navigationState,
          builder: (context, state) {
            Widget child;
            switch (state) {
              case BottomNavigationState.home:
                child = const HomeView();
              case BottomNavigationState.discovery:
                child =const DiscoveryView();
              case BottomNavigationState.form:
                child =const FormView();
              case BottomNavigationState.chat:
                child =const ProfileView();
              case BottomNavigationState.profile:
                child =const ProfileView();
              default:
                child = const HomeView();
            }
            return child;
          },
        ),
      ),
    );
  }
}
