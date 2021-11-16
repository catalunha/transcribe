import 'package:flutter/foundation.dart';
import 'package:transcribe/team/controller/team_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class TeamState {
  final IList<TeamModel>? teamIList;
  final TeamModel? teamCurrent;
  TeamState({
    this.teamCurrent,
    this.teamIList,
  });
  factory TeamState.initialState() => TeamState(
        teamCurrent: null,
        teamIList: IList(),
      );
  TeamState copyWith({
    TeamModel? teamCurrent,
    List<TeamModel>? teamList,
    IList<TeamModel>? teamIList,
    bool teamCurrentSetNull = false,
    bool teamIListSetNull = false,
  }) {
    return TeamState(
      teamCurrent: teamCurrentSetNull ? null : teamCurrent ?? this.teamCurrent,
      teamIList: teamIList ?? this.teamIList,
    );
  }

  @override
  String toString() =>
      'TeamState(teamCurrent: $teamCurrent, teamList: $teamIList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeamState &&
        other.teamCurrent == teamCurrent &&
        other.teamIList == teamIList;
    // listEquals(other.teamIList, teamIList);
  }

  @override
  int get hashCode => teamCurrent.hashCode ^ teamIList.hashCode;
}
