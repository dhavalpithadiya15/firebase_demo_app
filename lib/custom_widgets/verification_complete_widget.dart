
import 'package:firebase_demo_app/custom_widgets/custom_button.dart';
import 'package:firebase_demo_app/custom_widgets/tittle_text.dart';
import 'package:firebase_demo_app/routes/routes.dart';
import 'package:firebase_demo_app/splash/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VerificationCompleted extends StatelessWidget {
  const VerificationCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/verification_success.svg", height: 100),
            const TittleText(text: "Verification\nSuccessful"),
            const SizedBox(
              height: 15,
            ),
            const Text("You now have full access to our system"),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
              onTap: () async {
                await SplashState.preferences.setBool('loginSuccess', true).then((value) {
                  Navigator.pushReplacementNamed(context, RoutesGenerator.mainScreen);
                });
              },
              text: "Let’s Combat!",
            )
          ],
        ),
      ),
    );
  }
}
