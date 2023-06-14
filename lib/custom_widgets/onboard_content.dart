import 'package:firebase_demo_app/authentication/login/login_cubit.dart';
import 'package:firebase_demo_app/authentication/login/login_view.dart';
import 'package:firebase_demo_app/authentication/register/email_and_password/email_password_cubit.dart';
import 'package:firebase_demo_app/authentication/register/email_and_password/email_password_view.dart';
import 'package:firebase_demo_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../colors/app_color.dart';
import '../onboard/onboard_cubit.dart';
import '../onboard/onboard_state.dart';
import '../splash/splash_state.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/tittle_text.dart';
class OnBoardContent extends StatelessWidget {
  final String image;
  final String tittle;
  final String description;

  const OnBoardContent({Key? key, required this.image, required this.tittle, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height;
    double totalWidth = MediaQuery.of(context).size.width;
    double bodyHeight = totalHeight - kBottomNavigationBarHeight;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: bodyHeight * 0.4,
          // color: Colors.blue,
          child: Align(
            alignment: Alignment.centerRight,
            child: Image.asset(image),
          ),
        ),
        Container(alignment: Alignment.center, child: TittleText(text: tittle)),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: totalWidth * 0.7,
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
        ),
        BlocBuilder<OnBoardCubit, OnBoardState>(
          builder: (context, state) {
            return Container(
              height: bodyHeight * 0.11,
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () => BlocProvider.of<OnBoardCubit>(context)..onSkip(),
                child: state.currentIndexPage == state.onBoardingList.length - 1
                    ? CustomButton(
                  onTap: () {
                    SplashState.preferences.setBool("showOnboard", false).then((value) => Navigator.pushReplacementNamed(context, RoutesGenerator.login)
                    );
                  },
                  text: "Let’s Combat!",
                )
                    : const Text(
                  "Skip",
                  style: TextStyle(
                    color: AppColor.secondaryColor,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}