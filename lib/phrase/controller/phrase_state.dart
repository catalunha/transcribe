import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'phrase_model.dart';

class PhraseState {
  final PhraseModel? phraseCurrent;
  final IList<PhraseModel>? phraseIList;
  final IList<PhraseModel>? phraseIListArchived;
  PhraseState({
    this.phraseCurrent,
    this.phraseIList,
    this.phraseIListArchived,
  });
  factory PhraseState.initialState() => PhraseState(
        phraseCurrent: null,
        phraseIList: IList(),
        phraseIListArchived: IList(),
      );
  PhraseState copyWith({
    PhraseModel? phraseCurrent,
    bool phraseCurrentSetNull = false,
    IList<PhraseModel>? phraseIList,
    IList<PhraseModel>? phraseIListArchived,
  }) {
    return PhraseState(
      phraseCurrent:
          phraseCurrentSetNull ? null : phraseCurrent ?? this.phraseCurrent,
      phraseIList: phraseIList ?? this.phraseIList,
      phraseIListArchived: phraseIListArchived ?? this.phraseIListArchived,
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
        other.phraseIListArchived == phraseIListArchived;
  }

  @override
  int get hashCode =>
      phraseCurrent.hashCode ^
      phraseIListArchived.hashCode ^
      phraseIList.hashCode;
}
