import 'package:firebase_demo_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../colors/app_color.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../custom_widgets/custom_text_field.dart';
import '../../../custom_widgets/tittle_text.dart';
import '../../register/email_and_password/email_password_cubit.dart';
import '../../register/email_and_password/email_password_state.dart';

class EmailPasswordView extends StatelessWidget {
  const EmailPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<EmailPasswordCubit, EmailPasswordState>(
        listener: (context, state) {
          if (state.isUserRegisteredSuccess) {
            Navigator.popAndPushNamed(context, RoutesGenerator.login);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Registered successfully!")));
          }
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/register_image.png"),
                const Align(alignment: Alignment.centerLeft, child: TittleText(text: "Create Account")),
                const SizedBox(
                  height: 15,
                ),
                const Align(alignment: Alignment.centerLeft, child: Text("Hi, kindly fill in the form to proceed\n combat")),
                CustomTextField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    } else {
                      return null;
                    }
                  },
                  labelText: 'Email',
                  controller: context.watch<EmailPasswordCubit>().state.emailController,
                ),
                BlocSelector<EmailPasswordCubit, EmailPasswordState, bool>(
                  selector: (state) {
                    return state.showPassword;
                  },
                  builder: (context, state) {
                    return CustomTextField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        }else{
                          return null;
                        }
                      },
                      labelText: 'Password',
                      controller: context.read<EmailPasswordCubit>().state.passwordController,
                      obscureText: state,
                      iconButton: IconButton(
                        onPressed: () => BlocProvider.of<EmailPasswordCubit>(context).changeShowPassword(),
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
                  child: CustomButton(
                    onTap: () async {
                      await BlocProvider.of<EmailPasswordCubit>(context).onEmailPasswordSubmit(context);
                    },
                    text: "Create Account",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Already have an account?",
                  style: TextStyle(fontSize: 12),
                ),
                InkWell(
                  onTap: () {
                    Navigator.popAndPushNamed(context, RoutesGenerator.login);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColor.primaryColor),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
