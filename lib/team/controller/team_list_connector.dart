import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/team/controller/team_action.dart';
import 'package:transcribe/team/controller/team_model.dart';

import '../../app_state.dart';
import '../team_list.dart';

class TeamListConnector extends StatelessWidget {
  const TeamListConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TeamListVm>(
      vm: () => TeamListVmFactory(this),
      onInit: (store) {
        store.dispatch(StreamDocsTeamAction());
      },
      builder: (context, vm) => TeamList(
        teamIList: vm.teamIList,
      ),
    );
  }
}

class TeamListVmFactory extends VmFactory<AppState, TeamListConnector> {
  TeamListVmFactory(widget) : super(widget);
  @override
  TeamListVm fromStore() => TeamListVm(
        teamIList: state.teamState.teamIList!,
      );
}

class TeamListVm extends Vm {
  final IList<TeamModel> teamIList;
  TeamListVm({
    required this.teamIList,
  }) : super(equals: [
          teamIList,
        ]);
}
