import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../colors/app_color.dart';
import '../custom_widgets/onboard_content.dart';
import '../onboard/onboard_state.dart';
import '../onboard/onboard_cubit.dart';
class OnBoardView extends StatelessWidget {
  const OnBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: BlocBuilder<OnBoardCubit, OnBoardState>(
        builder: (context, state) {
          return Container(
            color: Colors.white,
            alignment: Alignment.topCenter,
            height: kBottomNavigationBarHeight,
            child: DotsIndicator(
              dotsCount: state.onBoardingList.length,
              position: state.currentIndexPage.toInt(),
              decorator:  DotsDecorator(
                color: AppColor.inactiveDotColor, // Inactive color
                activeColor: AppColor.secondaryColor,
              ),
            ),
          );
        },
      ),
      body: BlocBuilder<OnBoardCubit, OnBoardState>(
        builder: (context, state) {
          return PageView.builder(
            onPageChanged: (value) =>BlocProvider.of<OnBoardCubit>(context).onPageChange(value.toDouble()),
            controller: state.pageController,
            itemCount: state.onBoardingList.length,
            itemBuilder: (context, index) {
              return OnBoardContent(
                image: state.onBoardingList[index].image,
                tittle: state.onBoardingList[index].tittle,
                description: state.onBoardingList[index].description,
              );
            },
          );
        },
      ),
    );
  }
}
