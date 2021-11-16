import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

import 'transcription_model.dart';

@immutable
class TranscriptionState {
  final IList<TranscriptionModel>? transcriptionIList;
  final TranscriptionModel? transcriptionCurrent;
  final IList<TranscriptionModel>? transcriptionIListArchived;
  const TranscriptionState({
    this.transcriptionCurrent,
    this.transcriptionIList,
    this.transcriptionIListArchived,
  });
  factory TranscriptionState.initialState() => TranscriptionState(
        transcriptionCurrent: null,
        transcriptionIList: IList(),
        transcriptionIListArchived: IList(),
      );
  TranscriptionState copyWith({
    TranscriptionModel? transcriptionCurrent,
    IList<TranscriptionModel>? transcriptionIList,
    IList<TranscriptionModel>? transcriptionIListArchived,
    bool transcriptionCurrentSetNull = false,
  }) {
    return TranscriptionState(
      transcriptionCurrent: transcriptionCurrentSetNull
          ? null
          : transcriptionCurrent ?? this.transcriptionCurrent,
      transcriptionIList: transcriptionIList ?? this.transcriptionIList,
      transcriptionIListArchived:
          transcriptionIListArchived ?? this.transcriptionIListArchived,
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
        other.transcriptionIList == transcriptionIList &&
        other.transcriptionIListArchived == transcriptionIListArchived;
  }

  @override
  int get hashCode =>
      transcriptionCurrent.hashCode ^
      transcriptionIList.hashCode ^
      transcriptionIListArchived.hashCode;
}
