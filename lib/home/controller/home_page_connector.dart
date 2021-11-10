import 'package:async_redux/async_redux.dart';

import 'package:flutter/material.dart';
import 'package:transcribe/login/controller/login_action.dart';

import '../../app_state.dart';
import '../home_page.dart';

class HomePageConnector extends StatelessWidget {
  const HomePageConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
      vm: () => HomeViewModelFactory(this),
      onInit: (store) {
        // store.dispatch(StreamDocsPhraseAction());
      },
      builder: (context, vm) => HomePage(
        signOut: vm.signOut,
        photoUrl: vm.photoUrl,
        displayName: vm.displayName,
        accessType: vm.accessType,
      ),
    );
  }
}

class HomeViewModelFactory extends VmFactory<AppState, HomePageConnector> {
  HomeViewModelFactory(widget) : super(widget);
  @override
  HomeViewModel fromStore() => HomeViewModel(
        signOut: () => dispatch(SignOutLoginAction()),
        photoUrl: state.userState.userCurrent!.photoURL ?? '',
        displayName: state.userState.userCurrent!.displayName ?? '',
        accessType: state.userState.userCurrent!.accessType,
      );
}

class HomeViewModel extends Vm {
  final VoidCallback signOut;

  final String displayName;
  final String photoUrl;
  final List<String> accessType;
  HomeViewModel({
    required this.signOut,
    required this.photoUrl,
    required this.displayName,
    required this.accessType,
  }) : super(equals: [
          photoUrl,
          displayName,
          accessType,
        ]);
}
