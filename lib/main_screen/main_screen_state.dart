import 'package:equatable/equatable.dart';
import 'package:firebase_demo_app/custom_widgets/custom_bottom_nav.dart';
import 'package:flutter/material.dart';

import '../modal/user_modal.dart';

class MainScreenState extends Equatable {
  final List<UserModal> usersList;
 final int selectedPage;
 final List<Widget> pages;
 final BottomNavigationState navigationState;
  @override
  List<Object?> get props => [usersList,selectedPage,pages,navigationState];

  const MainScreenState({
    this.selectedPage=0,
    this.usersList = const [],
    this.pages=const[],
    this.navigationState=BottomNavigationState.home
  });

  MainScreenState copyWith({
    List<UserModal>? usersList,
    int? selectedPage,
    List<Widget>? pages,
    BottomNavigationState? navigationState,
  }) {
    return MainScreenState(
      usersList: usersList ?? this.usersList,
      selectedPage: selectedPage ?? this.selectedPage,
      pages: pages ?? this.pages,
      navigationState: navigationState ?? this.navigationState,
    );
  }
}
