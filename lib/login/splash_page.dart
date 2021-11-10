import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  final bool isUnInitialized;
  final bool isAuthenticating;
  final bool isAuthenticated;
  final bool isUnAuthenticated;
  final bool isUnInitializedFirestore;
  final bool isCheckingInFirestore;
  final bool isInFirestore;
  final bool isOutFirestore;
  const SplashPage(
      {Key? key,
      required this.isUnInitialized,
      required this.isAuthenticating,
      required this.isAuthenticated,
      required this.isUnAuthenticated,
      required this.isUnInitializedFirestore,
      required this.isCheckingInFirestore,
      required this.isInFirestore,
      required this.isOutFirestore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
