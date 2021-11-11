import 'package:async_redux/async_redux.dart';

import 'phrase/controller/phrase_state.dart';
import 'team/controller/team_state.dart';
import 'user/controller/user_state.dart';
import 'users/controller/users_state.dart';

class AppState {
  final Wait wait;
  final UserState userState;
  final UsersState usersState;
  final TeamState teamState;
  final PhraseState phraseState;

  AppState({
    required this.wait,
    required this.userState,
    required this.usersState,
    required this.teamState,
    required this.phraseState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        userState: UserState.initialState(),
        usersState: UsersState.initialState(),
        teamState: TeamState.initialState(),
        phraseState: PhraseState.initialState(),
      );
  AppState copyWith({
    Wait? wait,
    UserState? userState,
    UsersState? usersState,
    TeamState? teamState,
    PhraseState? phraseState,
  }) {
    return AppState(
      wait: wait ?? this.wait,
      userState: userState ?? this.userState,
      usersState: usersState ?? this.usersState,
      teamState: teamState ?? this.teamState,
      phraseState: phraseState ?? this.phraseState,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.phraseState == phraseState &&
        other.teamState == teamState &&
        other.usersState == usersState &&
        other.userState == userState &&
        other.wait == wait;
  }

  @override
  int get hashCode {
    return userState.hashCode ^
        usersState.hashCode ^
        teamState.hashCode ^
        phraseState.hashCode ^
        wait.hashCode;
  }
}