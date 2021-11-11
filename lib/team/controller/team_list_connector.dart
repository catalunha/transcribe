import 'package:async_redux/async_redux.dart';
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
        teamList: vm.teamList,
      ),
    );
  }
}

class TeamListVmFactory extends VmFactory<AppState, TeamListConnector> {
  TeamListVmFactory(widget) : super(widget);
  @override
  TeamListVm fromStore() => TeamListVm(
        teamList: state.teamState.teamList!,
      );
}

class TeamListVm extends Vm {
  final List<TeamModel> teamList;
  TeamListVm({
    required this.teamList,
  }) : super(equals: [
          teamList,
        ]);
}
