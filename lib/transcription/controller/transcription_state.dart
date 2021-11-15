import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:transcribe/task/controller/task_model.dart';

import '../../task/controller/task_model.dart';
import 'transcription_model.dart';

@immutable
class TranscriptionState {
  final IList<TranscriptionModel>? transcriptionIList;
  final TranscriptionModel? transcriptionCurrent;
  const TranscriptionState({
    this.transcriptionCurrent,
    this.transcriptionIList,
  });
  factory TranscriptionState.initialState() => TranscriptionState(
        transcriptionCurrent: null,
        transcriptionIList: IList(),
      );
  TranscriptionState copyWith({
    TranscriptionModel? transcriptionCurrent,
    IList<TranscriptionModel>? transcriptionIList,
    bool taskPhraseCurrentSetNull = false,
    bool taskPhraseListSetNull = false,
  }) {
    // if (transcriptionIList != null) {
    //   for (var task in transcriptionIList) {
    //     print('copyWith list : $task');
    //   }
    // }
    // if (transcriptionIList == null || transcriptionIList.isEmpty) {
    //   print('copyWith list : null');
    // }
    // print('copyWith current: $transcriptionCurrent');
    // if (this.transcriptionIList != null) {
    //   for (var task in this.transcriptionIList!) {
    //     print('this list : $task');
    //   }
    // }
    // if (this.transcriptionIList == null || this.transcriptionIList!.isEmpty) {
    //   print('this list : null');
    // }
    // print('this current: ${this.transcriptionCurrent}');

    return TranscriptionState(
      transcriptionCurrent: taskPhraseCurrentSetNull
          ? null
          : transcriptionCurrent ?? this.transcriptionCurrent,
      transcriptionIList: transcriptionIList ?? this.transcriptionIList,
    );
  }

  @override
  String toString() =>
      'TranscriptionState(transcriptionCurrent: $transcriptionCurrent, taskList: $transcriptionIList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TranscriptionState &&
        runtimeType == other.runtimeType &&
        other.transcriptionCurrent == transcriptionCurrent &&
        other.transcriptionIList == transcriptionIList;
  }

  @override
  int get hashCode =>
      transcriptionCurrent.hashCode ^ transcriptionIList.hashCode;
}
