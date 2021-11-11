import 'package:flutter/foundation.dart';
import 'phrase_model.dart';

class PhraseState {
  final PhraseModel? phraseCurrent;
  final List<PhraseModel>? phraseList;
  final List<PhraseModel>? phraseArchivedList;
  PhraseState({
    this.phraseCurrent,
    this.phraseList,
    this.phraseArchivedList,
  });
  factory PhraseState.initialState() => PhraseState(
        phraseCurrent: null,
        phraseList: [],
        phraseArchivedList: [],
      );
  PhraseState copyWith({
    PhraseModel? phraseCurrent,
    bool phraseCurrentSetNull = false,
    List<PhraseModel>? phraseList,
    List<PhraseModel>? phraseArchivedList,
  }) {
    return PhraseState(
      phraseCurrent:
          phraseCurrentSetNull ? null : phraseCurrent ?? this.phraseCurrent,
      phraseList: phraseList ?? this.phraseList,
      phraseArchivedList: phraseArchivedList ?? this.phraseArchivedList,
    );
  }

  @override
  String toString() =>
      'PhraseState(phraseCurrent: $phraseCurrent, phraseList: $phraseList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhraseState &&
        other.phraseCurrent == phraseCurrent &&
        listEquals(other.phraseList, phraseList) &&
        listEquals(other.phraseArchivedList, phraseArchivedList);
  }

  @override
  int get hashCode =>
      phraseCurrent.hashCode ^
      phraseArchivedList.hashCode ^
      phraseList.hashCode;
}
