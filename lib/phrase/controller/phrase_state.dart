import 'package:flutter/foundation.dart';
import 'phrase_model.dart';

class PhraseState {
  final PhraseModel? phraseCurrent;
  final List<PhraseModel>? phraseList;
  final List<PhraseModel>? phraseArchivedList;
  final int? publicPhraseAmount;
  PhraseState({
    this.phraseCurrent,
    this.phraseList,
    this.phraseArchivedList,
    this.publicPhraseAmount,
  });
  factory PhraseState.initialState() => PhraseState(
        phraseCurrent: null,
        phraseList: [],
        phraseArchivedList: [],
        publicPhraseAmount: 0,
      );
  PhraseState copyWith({
    PhraseModel? phraseCurrent,
    bool phraseCurrentSetNull = false,
    List<PhraseModel>? phraseList,
    List<PhraseModel>? phraseArchivedList,
    int? publicPhraseAmount,
  }) {
    return PhraseState(
      phraseCurrent:
          phraseCurrentSetNull ? null : phraseCurrent ?? this.phraseCurrent,
      phraseList: phraseList ?? this.phraseList,
      phraseArchivedList: phraseArchivedList ?? this.phraseArchivedList,
      publicPhraseAmount: publicPhraseAmount ?? this.publicPhraseAmount,
    );
  }

  @override
  String toString() =>
      'PhraseState(phraseCurrent: $phraseCurrent, phraseList: $phraseList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhraseState &&
        other.publicPhraseAmount == publicPhraseAmount &&
        other.phraseCurrent == phraseCurrent &&
        listEquals(other.phraseList, phraseList) &&
        listEquals(other.phraseArchivedList, phraseArchivedList);
  }

  @override
  int get hashCode =>
      publicPhraseAmount.hashCode ^
      phraseCurrent.hashCode ^
      phraseArchivedList.hashCode ^
      phraseList.hashCode;
}
