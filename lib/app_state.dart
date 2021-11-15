import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';

import 'phrase/controller/phrase_state.dart';
import 'task/controller/task_state.dart';
import 'team/controller/team_state.dart';
import 'transcription/controller/transcription_state.dart';
import 'upload/controller/upload_state.dart';
import 'user/controller/user_state.dart';
import 'users/controller/users_state.dart';

@immutable
class AppState {
  final Wait wait;
  final UserState userState;
  final UsersState usersState;
  final TeamState teamState;
  final PhraseState phraseState;
  final UploadState uploadState;
  final TaskState taskState;
  final TranscriptionState transcriptionState;

  const AppState({
    required this.wait,
    required this.userState,
    required this.usersState,
    required this.teamState,
    required this.phraseState,
    required this.uploadState,
    required this.taskState,
    required this.transcriptionState,
  });

  static AppState initialState() => AppState(
        wait: Wait(),
        userState: UserState.initialState(),
        usersState: UsersState.initialState(),
        teamState: TeamState.initialState(),
        phraseState: PhraseState.initialState(),
        uploadState: UploadState.initialState(),
        taskState: TaskState.initialState(),
        transcriptionState: TranscriptionState.initialState(),
      );
  AppState copyWith({
    Wait? wait,
    UserState? userState,
    UsersState? usersState,
    TeamState? teamState,
    PhraseState? phraseState,
    UploadState? uploadState,
    TaskState? taskState,
    TranscriptionState? transcriptionState,
  }) {
    return AppState(
      wait: wait ?? this.wait,
      userState: userState ?? this.userState,
      usersState: usersState ?? this.usersState,
      teamState: teamState ?? this.teamState,
      phraseState: phraseState ?? this.phraseState,
      uploadState: uploadState ?? this.uploadState,
      taskState: taskState ?? this.taskState,
      transcriptionState: transcriptionState ?? this.transcriptionState,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppState &&
        runtimeType == other.runtimeType &&
        other.transcriptionState == transcriptionState &&
        other.taskState == taskState &&
        other.uploadState == uploadState &&
        other.phraseState == phraseState &&
        other.teamState == teamState &&
        other.usersState == usersState &&
        other.userState == userState &&
        other.wait == wait;
  }

  @override
  int get hashCode {
    return userState.hashCode ^
        transcriptionState.hashCode ^
        taskState.hashCode ^
        uploadState.hashCode ^
        usersState.hashCode ^
        teamState.hashCode ^
        phraseState.hashCode ^
        wait.hashCode;
  }
}
