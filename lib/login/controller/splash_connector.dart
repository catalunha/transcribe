import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';
import 'package:transcribe/home/controller/home_page_connector.dart';
import 'package:transcribe/user/controller/user_state.dart';

import '../../app_state.dart';
import '../splash_page.dart';
import 'login_action.dart';
import 'login_connector.dart';

class SplashConnector extends StatelessWidget {
  const SplashConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SplashViewModel>(
        vm: () => SplashViewModelFactory(this),
        builder: (context, vm) {
          if (vm.isUnInitialized) {
            vm.startLogin();
          }
          if (vm.isAuthenticated && vm.isInFirestore) {
            return HomePageConnector();
          }
          if (vm.isUnAuthenticated && !vm.isAuthenticating) {
            return LoginConnector();
          }
          return SplashPage(
            isUnInitialized: vm.isUnInitialized,
            isAuthenticating: vm.isAuthenticating,
            isAuthenticated: vm.isAuthenticated,
            isUnAuthenticated: vm.isUnAuthenticated,
            isUnInitializedFirestore: vm.isUnInitializedFirestore,
            isCheckingInFirestore: vm.isCheckingInFirestore,
            isInFirestore: vm.isInFirestore,
            isOutFirestore: vm.isOutFirestore,
          );
        });
  }
}

class SplashViewModelFactory extends VmFactory<AppState, SplashConnector> {
  SplashViewModelFactory(widget) : super(widget);

  @override
  SplashViewModel fromStore() {
    return SplashViewModel(
      isUnInitialized: state.userState.statusFirebaseAuth ==
          StatusFirebaseAuth.unInitialized,
      isAuthenticating: state.userState.statusFirebaseAuth ==
          StatusFirebaseAuth.authenticating,
      isAuthenticated: state.userState.statusFirebaseAuth ==
          StatusFirebaseAuth.authenticated,
      isUnAuthenticated: state.userState.statusFirebaseAuth ==
          StatusFirebaseAuth.unAuthenticated,
      isUnInitializedFirestore: state.userState.statusFirestoreUser ==
          StatusFirestoreUser.unInitialized,
      isCheckingInFirestore: state.userState.statusFirestoreUser ==
          StatusFirestoreUser.checkingInFirestore,
      isInFirestore: state.userState.statusFirestoreUser ==
          StatusFirestoreUser.inFirestore,
      isOutFirestore: state.userState.statusFirestoreUser ==
          StatusFirestoreUser.outFirestore,
      startLogin: () async {
        dispatch(CheckLoginAction());
      },
    );
  }
}

class SplashViewModel extends Vm {
  final bool isUnInitialized;
  final bool isAuthenticating;
  final bool isAuthenticated;
  final bool isUnAuthenticated;
  final bool isUnInitializedFirestore;
  final bool isCheckingInFirestore;
  final bool isInFirestore;
  final bool isOutFirestore;
  final VoidCallback startLogin;

  SplashViewModel({
    required this.isUnInitialized,
    required this.isAuthenticating,
    required this.isAuthenticated,
    required this.isUnAuthenticated,
    required this.isUnInitializedFirestore,
    required this.isCheckingInFirestore,
    required this.isInFirestore,
    required this.isOutFirestore,
    required this.startLogin,
  }) : super(equals: [
          isUnInitialized,
          isAuthenticating,
          isAuthenticated,
          isUnAuthenticated,
          isUnInitializedFirestore,
          isCheckingInFirestore,
          isInFirestore,
          isOutFirestore,
        ]);
}
