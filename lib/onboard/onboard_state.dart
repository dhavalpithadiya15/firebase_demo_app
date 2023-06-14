
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../modal/onboard_modal.dart';

class OnBoardState extends Equatable {
  final List<OnBoardingModal> onBoardingList;
  final PageController pageController;
  final double currentIndexPage;

  const OnBoardState({
    this.onBoardingList = const [],
    required this.pageController,
    this.currentIndexPage=0,
  });

  @override
  List<Object?> get props => [onBoardingList, pageController,currentIndexPage];

  OnBoardState copyWith({
    List<OnBoardingModal>? onBoardingList,
    PageController? pageController,
    double? currentIndexPage,
  }) {
    return OnBoardState(
      onBoardingList: onBoardingList ?? this.onBoardingList,
      pageController: pageController ?? this.pageController,
      currentIndexPage: currentIndexPage ?? this.currentIndexPage,
    );
  }
}
