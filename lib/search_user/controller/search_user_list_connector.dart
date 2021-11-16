import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/user/controller/user_model.dart';

import '../../app_state.dart';
import '../search_user_list.dart';
import 'search_user_action.dart';

class SearchUserListConnector extends StatelessWidget {
  const SearchUserListConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, UsersPageVm>(
      vm: () => UsersPageVmFactory(this),
      onInit: (store) async {
        await store.dispatch(ReadDocsUserSearchUserAction());
      },
      builder: (context, vm) => SearchUserList(
        userIdIListInTeam: vm.userIdIListInTeam,
        userRefIList: vm.userRefIList,
        onAddOrDeleteUser: vm.onAddOrDeleteUser,
      ),
    );
  }
}

class UsersPageVmFactory extends VmFactory<AppState, SearchUserListConnector> {
  UsersPageVmFactory(widget) : super(widget);
  @override
  UsersPageVm fromStore() => UsersPageVm(
        userIdIListInTeam: state.teamState.teamCurrent!.userMap.keys.toIList(),
        userRefIList: state.usersState.userRefIList!,
        onAddOrDeleteUser: (bool addOrDelete, String userId) {
          dispatch(AddOrDeleteUserInTeamSearchUserAction(
              addOrDelete: addOrDelete, userId: userId));
        },
      );
}

class UsersPageVm extends Vm {
  final IList<String> userIdIListInTeam;
  final IList<UserRef> userRefIList;
  final Function(bool, String) onAddOrDeleteUser;

  UsersPageVm({
    required this.userIdIListInTeam,
    required this.userRefIList,
    required this.onAddOrDeleteUser,
  }) : super(equals: [
          userIdIListInTeam,
          userRefIList,
        ]);
}
