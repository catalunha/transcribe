import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'phrase_model.dart';

class PhraseState {
  final PhraseModel? phraseCurrent;
  final IList<PhraseModel>? phraseIList;
  final IList<PhraseModel>? phraseArchivedIList;
  PhraseState({
    this.phraseCurrent,
    this.phraseIList,
    this.phraseArchivedIList,
  });
  factory PhraseState.initialState() => PhraseState(
        phraseCurrent: null,
        phraseIList: IList(),
        phraseArchivedIList: IList(),
      );
  PhraseState copyWith({
    PhraseModel? phraseCurrent,
    bool phraseCurrentSetNull = false,
    IList<PhraseModel>? phraseIList,
    IList<PhraseModel>? phraseArchivedIList,
  }) {
    return PhraseState(
      phraseCurrent:
          phraseCurrentSetNull ? null : phraseCurrent ?? this.phraseCurrent,
      phraseIList: phraseIList ?? this.phraseIList,
      phraseArchivedIList: phraseArchivedIList ?? this.phraseArchivedIList,
    );
  }

  @override
  String toString() =>
      'PhraseState(phraseCurrent: $phraseCurrent, phraseList: $phraseIList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhraseState &&
        other.phraseCurrent == phraseCurrent &&
        other.phraseIList == phraseIList &&
        other.phraseArchivedIList == phraseArchivedIList;
  }

  @override
  int get hashCode =>
      phraseCurrent.hashCode ^
      phraseArchivedIList.hashCode ^
      phraseIList.hashCode;
}
