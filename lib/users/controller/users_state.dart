import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:transcribe/user/controller/user_model.dart';

class UsersState {
  final UserRef? userRefCurrent;
  final IList<UserRef>? userRefIList;
  UsersState({
    this.userRefCurrent,
    this.userRefIList,
  });
  factory UsersState.initialState() => UsersState(
        userRefCurrent: null,
        userRefIList: IList(),
      );
  UsersState copyWith({
    UserRef? userRefCurrent,
    bool userRefCurrentSetNull = false,
    IList<UserRef>? userRefIList,
    int? countPhrases,
  }) {
    return UsersState(
      userRefCurrent:
          userRefCurrentSetNull ? null : userRefCurrent ?? this.userRefCurrent,
      userRefIList: userRefIList ?? this.userRefIList,
    );
  }

  @override
  String toString() =>
      'UsersState(userRefCurrent: $userRefCurrent, userRefList: $userRefIList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UsersState &&
        other.userRefCurrent == userRefCurrent &&
        other.userRefIList == userRefIList;
  }

  @override
  int get hashCode => userRefCurrent.hashCode ^ userRefIList.hashCode;
}
