import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/team/controller/team_action.dart';
import 'package:transcribe/user/controller/user_model.dart';

import '../../app_state.dart';
import '../users_list.dart';
import 'users_action.dart';

class UsersListConnector extends StatelessWidget {
  const UsersListConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UsersPageVm>(
      vm: () => UsersPageVmFactory(this),
      onInit: (store) async {
        await store.dispatch(ReadDocsUserUsersAction());
      },
      builder: (context, vm) => UsersList(
        userIdListInTeam: vm.userIdListInTeam,
        userRefList: vm.userRefList,
        onAddOrDeleteUser: vm.onAddOrDeleteUser,
      ),
    );
  }
}

class UsersPageVmFactory extends VmFactory<AppState, UsersListConnector> {
  UsersPageVmFactory(widget) : super(widget);
  @override
  UsersPageVm fromStore() => UsersPageVm(
        userIdListInTeam: state.teamState.teamCurrent!.userMap.keys.toList(),
        userRefList: state.usersState.userRefList!,
        onAddOrDeleteUser: (bool addOrDelete, String userId) {
          dispatch(AddOrDeleteUserTeamAction(
              addOrDelete: addOrDelete, userId: userId));
        },
      );
}

class UsersPageVm extends Vm {
  final List<String> userIdListInTeam;
  final List<UserRef> userRefList;
  final Function(bool, String) onAddOrDeleteUser;

  UsersPageVm({
    required this.userIdListInTeam,
    required this.userRefList,
    required this.onAddOrDeleteUser,
  }) : super(equals: [
          userIdListInTeam,
          userRefList,
        ]);
}
