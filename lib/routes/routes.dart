import 'package:firebase_demo_app/authentication/login/login_view.dart';
import 'package:firebase_demo_app/authentication/register/email_and_password/email_password_cubit.dart';
import 'package:firebase_demo_app/authentication/register/email_and_password/email_password_view.dart';
import 'package:firebase_demo_app/authentication/register/phone_number/phone_number_view.dart';
import 'package:firebase_demo_app/authentication/register/phone_number/submit_otp/submit_otp_view.dart';
import 'package:firebase_demo_app/custom_widgets/verification_complete_widget.dart';
import 'package:firebase_demo_app/main_screen/form/form_view.dart';
import 'package:firebase_demo_app/main_screen/home/home_view.dart';

import '../main_screen/main_screen_cubit.dart';
import '../main_screen/main_screen_view.dart';
import 'package:firebase_demo_app/onboard/onboard_cubit.dart';
import 'package:firebase_demo_app/onboard/onboard_view.dart';
import 'package:firebase_demo_app/splash/splash_cubit.dart';
import 'package:firebase_demo_app/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoutesGenerator {
  static const String splash = "/";
  static const String onBoard = "/onBoard";
  static const String register = "/register";
  static const String login = "/login";
  static const String mainScreen = "/mainScreen";
  static const String phoneNumber = "/phoneNumber";
  static const String submitOtp = "/submitOtp";
  static const String verificationSubmit = "/verificationSubmit";
  static const String home = "/home";
  static const String form = "/form";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesGenerator.splash:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => SplashCubit(),
            child: const SplashView(),
          ),
        );
      case RoutesGenerator.onBoard:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => OnBoardCubit(),
            child: const OnBoardView(),
          ),
        );
      case RoutesGenerator.login:
        return MaterialPageRoute(builder: (context) => const LoginView());
      case RoutesGenerator.register:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => EmailPasswordCubit(),
            child: const EmailPasswordView(),
          ),
        );
      case RoutesGenerator.form:
        var data = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => FormView(documentId: data),
        );
      case RoutesGenerator.phoneNumber:
        return MaterialPageRoute(
          builder: (context) => const PhoneNumberView(),
        );
      case RoutesGenerator.submitOtp:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context) => SubmitOtpView(completeNumber: data["completeNumber"], verificationId: data["verificationId"]));
      case RoutesGenerator.mainScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => MainScreenCubit(),
            child: const MainScreenView(),
          ),
        );
      case RoutesGenerator.verificationSubmit:
        return MaterialPageRoute(
          builder: (context) => const VerificationCompleted(),
        );
      case RoutesGenerator.home:
        return MaterialPageRoute(builder: (context) => const HomeView());
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('ERROR'),
          ),
        );
      },
    );
  }
}
