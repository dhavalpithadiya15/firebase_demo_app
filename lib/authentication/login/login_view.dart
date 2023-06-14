import 'package:firebase_demo_app/routes/routes.dart';
import 'package:firebase_demo_app/splash/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../colors/app_color.dart';
import '../../custom_widgets/custom_button.dart';
import '../../custom_widgets/custom_circle_button.dart';
import '../../custom_widgets/custom_text_field.dart';
import '../../custom_widgets/tittle_text.dart';
import './login_cubit.dart';
import './login_state.dart';
import '../../helper/helper.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalHeight = MediaQuery.of(context).size.height - kToolbarHeight;

    return BlocProvider(
      create: (context) {
        print("LOGIN CUBIT INITIALISED FROM LOGIN VIEW TOP");
        return LoginCubit();
      },
      child: Builder(builder: (context) {
        return BlocListener<LoginCubit, LoginState>(
          listener: (context, state) async {
            if (state.isUserLoginSuccess) {
              await Helper.loginSuccessDialog(context).then(
                (value) async {
                  SplashState.preferences.setBool("loginSuccess", true);
                  Navigator.pushReplacementNamed(context, RoutesGenerator.mainScreen);
                },
              );
            }
          },
          child: Scaffold(
            body: SafeArea(
              child: ScrollConfiguration(
                behavior: const ScrollBehavior().copyWith(overscroll: false),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: totalHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset("assets/images/login_image.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: TittleText(text: "Welcome Back!"),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Hi, Kindly login to continue battle"),
                              ),
                              CustomTextField(
                                labelText: 'Email',
                                controller: context.watch<LoginCubit>().state.emailController,
                              ),
                              BlocSelector<LoginCubit, LoginState, bool>(
                                selector: (state) {
                                  return state.showPassword;
                                },
                                builder: (context, state) {
                                  return CustomTextField(
                                    labelText: 'Password',
                                    controller: context.watch<LoginCubit>().state.passwordController,
                                    obscureText: state,
                                    iconButton: IconButton(
                                      onPressed: () => BlocProvider.of<LoginCubit>(context).changeShowPassword(),
                                      icon: state
                                          ? const Icon(
                                              Icons.visibility_off_sharp,
                                              size: 17,
                                            )
                                          : const Icon(Icons.visibility, size: 17),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: CustomButton(onTap: () async {
                                 await BlocProvider.of<LoginCubit>(context).onLoginSubmit(context);
                                }, text: "Let’s Combat!"),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Connect With:",
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomCircleButton(
                                    onTap: () {
                                      BlocProvider.of<LoginCubit>(context).signInWithGoogle();
                                    },
                                    color: const Color(0xffF34A38),
                                    child: SvgPicture.asset("assets/images/Icon.svg", height: 12),
                                  ),
                                  CustomCircleButton(
                                    color: Colors.green,
                                    onTap: () => Navigator.pushNamed(context, RoutesGenerator.phoneNumber),
                                    child: const Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Don’t have an account?",
                                style: TextStyle(fontSize: 12),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(context, RoutesGenerator.register);
                                },
                                child: const Text(
                                  "Create Account",
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColor.primaryColor),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
