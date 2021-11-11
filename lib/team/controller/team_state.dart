import 'package:flutter/foundation.dart';
import 'package:transcribe/team/controller/team_model.dart';

class TeamState {
  final List<TeamModel>? teamList;
  final TeamModel? teamCurrent;
  TeamState({
    this.teamCurrent,
    this.teamList,
  });
  factory TeamState.initialState() => TeamState(
        teamCurrent: null,
        teamList: [],
      );
  TeamState copyWith({
    TeamModel? teamCurrent,
    List<TeamModel>? teamList,
    bool teamPhraseCurrentSetNull = false,
    bool teamPhraseListSetNull = false,
  }) {
    return TeamState(
      teamCurrent: teamCurrent ?? this.teamCurrent,
      teamList: teamList ?? this.teamList,
    );
  }

  @override
  String toString() =>
      'TeamState(teamCurrent: $teamCurrent, teamList: $teamList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeamState &&
        other.teamCurrent == teamCurrent &&
        listEquals(other.teamList, teamList);
  }

  @override
  int get hashCode => teamCurrent.hashCode ^ teamList.hashCode;
}
