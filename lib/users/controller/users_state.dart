import 'package:flutter/foundation.dart';
import 'package:transcribe/user/controller/user_model.dart';

class UsersState {
  final UserModel? usersCurrent;
  final List<UserModel>? usersList;
  UsersState({
    this.usersCurrent,
    this.usersList,
  });
  factory UsersState.initialState() => UsersState(
        usersCurrent: null,
        usersList: [],
      );
  UsersState copyWith({
    UserModel? usersCurrent,
    bool usersCurrentSetNull = false,
    List<UserModel>? usersList,
    int? countPhrases,
  }) {
    return UsersState(
      usersCurrent:
          usersCurrentSetNull ? null : usersCurrent ?? this.usersCurrent,
      usersList: usersList ?? this.usersList,
    );
  }

  @override
  String toString() =>
      'UsersState(usersCurrent: $usersCurrent, usersList: $usersList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersState &&
        other.usersCurrent == usersCurrent &&
        listEquals(other.usersList, usersList);
  }

  @override
  int get hashCode => usersCurrent.hashCode ^ usersList.hashCode;
}
