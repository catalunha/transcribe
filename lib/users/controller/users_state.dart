import 'package:flutter/foundation.dart';
import 'package:transcribe/user/controller/user_model.dart';

class UsersState {
  final UserRef? userRefCurrent;
  final List<UserRef>? userRefList;
  UsersState({
    this.userRefCurrent,
    this.userRefList,
  });
  factory UsersState.initialState() => UsersState(
        userRefCurrent: null,
        userRefList: [],
      );
  UsersState copyWith({
    UserRef? userRefCurrent,
    bool userRefCurrentSetNull = false,
    List<UserRef>? userRefList,
    int? countPhrases,
  }) {
    return UsersState(
      userRefCurrent:
          userRefCurrentSetNull ? null : userRefCurrent ?? this.userRefCurrent,
      userRefList: userRefList ?? this.userRefList,
    );
  }

  @override
  String toString() =>
      'UsersState(userRefCurrent: $userRefCurrent, userRefList: $userRefList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersState &&
        other.userRefCurrent == userRefCurrent &&
        listEquals(other.userRefList, userRefList);
  }

  @override
  int get hashCode => userRefCurrent.hashCode ^ userRefList.hashCode;
}
