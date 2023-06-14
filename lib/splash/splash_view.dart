
import 'package:firebase_demo_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../colors/app_color.dart';
import '../onboard/onboard_view.dart';
import '../splash/splash_cubit.dart';
import '../splash/splash_state.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.showOnboard) {
          Future.delayed(const Duration(seconds: 3)).then(
            (value) => Navigator.pushReplacementNamed(context, RoutesGenerator.onBoard)
          );
        } else if (!state.showOnboard && state.loginSuccess) {
          Future.delayed(const Duration(seconds: 3)).then(
            (value) => Navigator.pushReplacementNamed(context, RoutesGenerator.mainScreen)
          );
        } else {
          Future.delayed(const Duration(seconds: 3)).then(
            (value) => Navigator.pushReplacementNamed(context, RoutesGenerator.login)
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Stack(
          children: [
            Center(
              child: SvgPicture.asset("assets/images/Logo.svg"),
            ),
            Positioned(
              bottom: 0,
              child: SvgPicture.asset("assets/images/splash_image.svg"),
            ),
          ],
        ),
      ),
    );
  }
}
