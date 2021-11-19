import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_images.dart';

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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const SizedBox(height: 100),
            Image.asset(
              AppImages.login,
              // width: 192,
              // height: 192,
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
              style:
                  OutlinedButton.styleFrom(padding: const EdgeInsets.all(20)),
            ),
          ],
        ),
      ),
    );
  }
}
