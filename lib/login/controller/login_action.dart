import 'package:async_redux/async_redux.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:transcribe/user/controller/user_action.dart';
import 'package:transcribe/user/controller/user_state.dart';

import '../../app_state.dart';

class ChangeStatusFirebaseAuthLoginAction extends ReduxAction<AppState> {
  final StatusFirebaseAuth statusFirebaseAuth;

  ChangeStatusFirebaseAuthLoginAction({required this.statusFirebaseAuth});
  @override
  AppState reduce() {
    return state.copyWith(
        userState: state.userState.copyWith(
      statusFirebaseAuth: statusFirebaseAuth,
    ));
  }
}

class ChangeUserLoginAction extends ReduxAction<AppState> {
  final User userFirebaseAuth;

  ChangeUserLoginAction({required this.userFirebaseAuth});
  @override
  AppState reduce() {
    return state.copyWith(
        userState: state.userState.copyWith(
      userFirebaseAuth: userFirebaseAuth,
    ));
  }
}

class CheckLoginAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    dispatch(ChangeStatusFirebaseAuthLoginAction(
        statusFirebaseAuth: StatusFirebaseAuth.authenticating));
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        dispatch(ChangeStatusFirebaseAuthLoginAction(
            statusFirebaseAuth: StatusFirebaseAuth.unAuthenticated));
      } else {
        await dispatch(ChangeUserLoginAction(userFirebaseAuth: user));
        await dispatch(ChangeStatusFirebaseAuthLoginAction(
            statusFirebaseAuth: StatusFirebaseAuth.authenticated));

        await dispatch(GetDocGoogleAccountUserAction(uid: user.uid));
      }
    });

    return null;
  }
}

class SignInLoginAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    try {
      var google = GoogleSignInOrSignOut();
      await google.googleLogin();
    } catch (e) {
      // print('--> SignInLoginAction: $e');
    }

    return null;
  }
}

class SignOutLoginAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    var google = GoogleSignInOrSignOut();
    await google.googleLogout();
    return state.copyWith(
      userState: UserState.initialState(),
    );
  }

  @override
  void after() => dispatch(ChangeStatusFirebaseAuthLoginAction(
      statusFirebaseAuth: StatusFirebaseAuth.unAuthenticated));
}

class GoogleSignInOrSignOut {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future<bool> googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return false;
      _user = googleUser;
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> googleLogout() async {
    await googleSignIn.disconnect();
    await FirebaseAuth.instance.signOut();
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return true;
    } else {
      return false;
    }
  }
}
