import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:firebase_demo_app/colors/app_color.dart';
import '../main_screen/main_screen_cubit.dart';
import '../main_screen/main_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      const BottomNavItem(icon: Icons.home, navigationState: BottomNavigationState.home,label: "home"),
      const BottomNavItem(icon: Icons.location_on_outlined, navigationState: BottomNavigationState.discovery,label: "discovery"),
      const BottomNavItem(icon: Icons.calendar_month_outlined, navigationState: BottomNavigationState.form,label: "form"),
      const BottomNavItem(icon: Icons.message, navigationState: BottomNavigationState.chat,label: "message"),
      const BottomNavItem(icon: Icons.people, navigationState: BottomNavigationState.profile,label: "home"),
    ];
    return Container(
      alignment: Alignment.center,
      color: AppColor.primaryColor,
      height: kToolbarHeight+30,
      child: Row(children: items.map((e) => Expanded(child: e)).toList()),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final BottomNavigationState navigationState;
  final String label;
  const BottomNavItem({Key? key, required this.icon, required this.navigationState, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isSelected =context.select<MainScreenCubit,bool>((value) => value.state.navigationState== navigationState);
    return GestureDetector(
      onTap: () => BlocProvider.of<MainScreenCubit>(context).updateTab(navigationState),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon ,color: isSelected?Colors.white:Colors.white.withOpacity(0.5),size: 30,),
          const SizedBox(height: 3,),
          Text(label,style: TextStyle(color: isSelected?Colors.white:Colors.white.withOpacity(0.5),),)
        ],
      ),
    );
  }
}

class Style extends StyleHook {
  @override
  double get activeIconMargin => 10;

  @override
  double get activeIconSize => 30;

  @override
  double? get iconSize => 30;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(
      color: color,
      fontFamily: fontFamily,
    );
  }
}

enum BottomNavigationState { home, discovery, form, chat, profile }
