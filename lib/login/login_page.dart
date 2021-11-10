import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_images.dart';

import 'google_login_button.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback signIn;
  const LoginPage({
    Key? key,
    required this.signIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // backgroundColor: AppColors.background,
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height * 0.4,
              color: Colors.green,
            ),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Image.asset(
                    AppImages.waveLine,
                    width: 208,
                    height: 273,
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      'Welcome to Transcribing.',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // GoogleLoginButton(
                  //   onTap: signIn,
                  // ),
                  OutlinedButton.icon(
                    onPressed: signIn,
                    icon: Image.asset(AppImages.google),
                    label: const Text(
                      'Select your GOOGLE account',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(20)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
