import 'package:async_redux/async_redux.dart';

import 'phrase/controller/phrase_state.dart';
import 'user/controller/user_state.dart';
import 'users/controller/users_state.dart';

class AppState {
  final Wait wait;
  final UserState userState;
  final UsersState usersState;
  final PhraseState phraseState;

  AppState({
    required this.wait,
    required this.userState,
    required this.phraseState,
    required this.usersState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        userState: UserState.initialState(),
        phraseState: PhraseState.initialState(),
        usersState: UsersState.initialState(),
      );
  AppState copyWith({
    Wait? wait,
    UserState? userState,
    PhraseState? phraseState,
    UsersState? usersState,
  }) {
    return AppState(
      wait: wait ?? this.wait,
      userState: userState ?? this.userState,
      phraseState: phraseState ?? this.phraseState,
      usersState: usersState ?? this.usersState,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        other.phraseState == phraseState &&
        other.usersState == usersState &&
        other.userState == userState &&
        other.wait == wait;
  }

  @override
  int get hashCode {
    return phraseState.hashCode ^
        usersState.hashCode ^
        userState.hashCode ^
        wait.hashCode;
  }
}
