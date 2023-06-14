import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../onboard/onboard_state.dart';
import '../modal/onboard_modal.dart';

class OnBoardCubit extends Cubit<OnBoardState> {
  OnBoardCubit() : super(OnBoardState(pageController: PageController())) {
    addOnBoardingData();
  }

  void addOnBoardingData() {
    List<OnBoardingModal> tempList = List.from(state.onBoardingList);
    tempList = [
      const OnBoardingModal(
        tittle: "Get Paid! Playing\n Video Game",
        description: "Earn points and real cash when you win a battle with no delay in cashing out",
        image: "assets/images/onboard_image1.png",
      ),
      const OnBoardingModal(
        tittle: "Schedule Games\n With Friends ",
        description: "Easily create an upcoming event and get ready for battle. Yeah! real combat fella.",
        image: "assets/images/onboard_image2.png",
      ),
      const OnBoardingModal(
        tittle: "Text, Audio and\n Video Chat",
        description: "Intuitive real life experience on mobile. Chat with fellow gamers before and after combat for free!",
        image: "assets/images/onboard_image3.png",
      )
    ];
    emit(state.copyWith(onBoardingList: tempList));
  }


  void onPageChange(double value) {
    print(value);
    emit(state.copyWith(currentIndexPage: value));
  }

  void onSkip() {
    state.pageController.jumpToPage(state.onBoardingList.length);
  }
}
