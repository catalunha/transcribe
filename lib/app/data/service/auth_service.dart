import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends GetxService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn googleSign = GoogleSignIn();
  late Rx<User?> firebaseUser;
  late Rx<GoogleSignInAccount?> googleSignInAccount;
  // late Function(User?) setInitialScreenFirebaseUser;
  // late Function(GoogleSignInAccount?) setInitialScreenGoogle;
  // @override
  // void onReady() {
  //   super.onReady();
  //   // auth is comning from the constants.dart file but it is basically FirebaseAuth.instance.
  //   // Since we have to use that many times I just made a constant file and declared there

  //   // firebaseUser = Rx<User?>(firebaseAuth.currentUser);
  //   // googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

  //   // firebaseUser.bindStream(firebaseAuth.userChanges());
  //   //   ever(firebaseUser, setInitialScreenFirebaseUser!);
  //   // // ever(firebaseUser, _setInitialScreen);

  //   // googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
  //   //   ever(googleSignInAccount, setInitialScreenGoogle!);
  //   // // ever(googleSignInAccount, _setInitialScreenGoogle);
  // }

  startService({
    required Function(User?) setInitialScreenFirebaseUser,
    required Function(GoogleSignInAccount?) setInitialScreenGoogle,
  }) {
    firebaseUser = Rx<User?>(firebaseAuth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

    firebaseUser.bindStream(firebaseAuth.userChanges());
    ever(firebaseUser, setInitialScreenFirebaseUser);
    // ever(firebaseUser, _setInitialScreen);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, setInitialScreenGoogle);
  }
  // _setInitialScreen(User? user) {
  //   print('_setInitialScreen');

  //   if (user == null) {
  //     print('_setInitialScreen: user==null');

  //     // if the user is not found then the user is navigated to the LoginPage
  //     // Get.offAll(() => const LoginPage());
  //     Get.offAllNamed(
  //       RoutesPaths.login,
  //     );
  //   } else {
  //     print('_setInitialScreen: user!=null');

  //     // if the user exists and logged in the the user is navigated to the HomePage
  //     // Get.offAll(() => HomePage());
  //     Get.offAllNamed(
  //       RoutesPaths.home,
  //     );
  //   }
  // }

  // _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
  //   print('_setInitialScreenGoogle');
  //   if (googleSignInAccount == null) {
  //     print('_setInitialScreenGoogle: googleSignInAccount==null');
  //     // if the user is not found then the user is navigated to the LoginPage
  //     Get.offAll(() => LoginPage());
  //     // Get.offAllNamed(
  //     //   RoutesPaths.login,
  //     // );
  //   } else {
  //     print('_setInitialScreenGoogle: googleSignInAccount!=null');

  //     print(googleSignInAccount.displayName);
  //     // if the user exists and logged in the the user is navigated to the HomePage
  //     Get.offAll(() => HomePage());
  //     // Get.offAllNamed(
  //     //   RoutesPaths.home,
  //     // );
  //   }
  // }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await firebaseAuth
            .signInWithCredential(credential)
            .catchError((onErr) {});
      }
    } catch (e) {
      Get.snackbar(
        "Error in signInWithGoogle",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      throw Exception('Some arbitrary error in signInWithGoogle');
    }
  }

  // void createUserWithEmailAndPassword(String email, password) async {
  //   try {
  //     await auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   } catch (firebaseAuthException) {}
  // }

  // void signInWithEmailAndPassword(String email, password) async {
  //   try {
  //     await auth.signInWithEmailAndPassword(email: email, password: password);
  //   } catch (firebaseAuthException) {}
  // }

  void signOut() async {
    await firebaseAuth.signOut();
    await googleSign.signOut();
  }
}
