import 'package:firebase_auth/firebase_auth.dart';

import 'user_model.dart';

enum StatusFirestoreUser {
  unInitialized,
  checkingInFirestore,
  inFirestore,
  outFirestore,
  errorFirestore,
}
enum StatusFirebaseAuth {
  unInitialized,
  authenticating,
  authenticated,
  unAuthenticated,
}

class UserState {
  final User? userFirebaseAuth;
  final UserModel? userCurrent;
  final StatusFirebaseAuth statusFirebaseAuth;
  final StatusFirestoreUser statusFirestoreUser;

  UserState({
    required this.userFirebaseAuth,
    required this.statusFirebaseAuth,
    required this.userCurrent,
    required this.statusFirestoreUser,
  });

  factory UserState.initialState() => UserState(
        userCurrent: null,
        statusFirestoreUser: StatusFirestoreUser.unInitialized,
        userFirebaseAuth: null,
        statusFirebaseAuth: StatusFirebaseAuth.unInitialized,
      );
  UserState copyWith({
    UserModel? userCurrent,
    StatusFirestoreUser? statusFirestoreUser,
    User? userFirebaseAuth,
    StatusFirebaseAuth? statusFirebaseAuth,
  }) =>
      UserState(
        userCurrent: userCurrent ?? this.userCurrent,
        statusFirestoreUser: statusFirestoreUser ?? this.statusFirestoreUser,
        userFirebaseAuth: userFirebaseAuth ?? this.userFirebaseAuth,
        statusFirebaseAuth: statusFirebaseAuth ?? this.statusFirebaseAuth,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserState &&
        other.userCurrent == userCurrent &&
        other.statusFirestoreUser == statusFirestoreUser &&
        other.userFirebaseAuth == userFirebaseAuth &&
        other.statusFirebaseAuth == statusFirebaseAuth;
  }

  @override
  int get hashCode =>
      userFirebaseAuth.hashCode ^
      statusFirebaseAuth.hashCode ^
      statusFirestoreUser.hashCode ^
      userCurrent.hashCode;
}
