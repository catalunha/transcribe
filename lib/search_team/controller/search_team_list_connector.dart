import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/task/controller/task_action.dart';
import 'package:transcribe/team/controller/team_action.dart';
import 'package:transcribe/team/controller/team_model.dart';

import '../../app_state.dart';
import '../search_team_list.dart';

class SearchTeamListConnector extends StatelessWidget {
  const SearchTeamListConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TeamListVm>(
      vm: () => TeamListVmFactory(this),
      onInit: (store) {
        if (store.state.teamState.teamIList?.isEmpty ?? false) {
          store.dispatch(StreamDocsTeamAction());
        }
      },
      builder: (context, vm) => SearchTeamList(
        teamIList: vm.teamIList,
        onSetTeam: vm.onSetTeam,
      ),
    );
  }
}

class TeamListVmFactory extends VmFactory<AppState, SearchTeamListConnector> {
  TeamListVmFactory(widget) : super(widget);
  @override
  TeamListVm fromStore() => TeamListVm(
        teamIList: state.teamState.teamIList!,
        onSetTeam: (String teamId) {
          dispatch(
            SetTeamTaskAction(teamId: teamId),
          );
        },
      );
}

class TeamListVm extends Vm {
  final IList<TeamModel> teamIList;
  final Function(String) onSetTeam;

  TeamListVm({
    required this.teamIList,
    required this.onSetTeam,
  }) : super(equals: [
          teamIList,
        ]);
}
