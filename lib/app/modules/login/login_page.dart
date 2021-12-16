import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/modules/auth/auth_controller.dart';
import 'package:transcribe/app/theme/app_images.dart';

class LoginPage extends GetView<AuthController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.login,
            ),
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                'Welcome to Transcribing.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            OutlinedButton.icon(
              onPressed: () {
                controller.signInWithGoogle();
              },
              icon: Image.asset(AppImages.google),
              label: const Text(
                'Select your GOOGLE account',
                style: TextStyle(fontSize: 16),
              ),
              style:
                  OutlinedButton.styleFrom(padding: const EdgeInsets.all(20)),
            ),
          ],
        ),
      ),
    );
  }
}
