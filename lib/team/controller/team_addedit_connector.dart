import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/team/controller/team_model.dart';

import '../../app_state.dart';
import '../team_addedit.dart';
import 'team_action.dart';

class TeamAddEditConnector extends StatelessWidget {
  final String addOrEditId;
  const TeamAddEditConnector({
    Key? key,
    required this.addOrEditId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TeamAddEditVm>(
      onInit: (store) {
        store.dispatch(SetTeamCurrentTeamAction(id: addOrEditId));
      },
      vm: () => TeamAddEditFactory(this),
      builder: (context, vm) => TeamAddEdit(
        formControllerTeam: vm.formControllerTeam,
        onSave: vm.onSave,
        onDeleteUser: vm.onDeleteUser,
      ),
    );
  }
}

class TeamAddEditFactory extends VmFactory<AppState, TeamAddEditConnector> {
  TeamAddEditFactory(widget) : super(widget);
  @override
  TeamAddEditVm fromStore() => TeamAddEditVm(
        formControllerTeam:
            FormControllerTeam(teamModel: state.teamState.teamCurrent!),
        onSave: (TeamModel teamModel) {
          if (widget!.addOrEditId.isEmpty) {
            dispatch(AddDocTeamAction(teamModel: teamModel));
          } else {
            dispatch(UpdateDocTeamAction(teamModel: teamModel));
          }
        },
        onDeleteUser: (bool addOrDelete, String userId) {
          dispatch(AddOrDeleteUserTeamAction(
              addOrDelete: addOrDelete, userId: userId));
        },
      );
}

class TeamAddEditVm extends Vm {
  final FormControllerTeam formControllerTeam;
  final Function(TeamModel) onSave;
  final Function(bool, String) onDeleteUser;

  TeamAddEditVm({
    required this.formControllerTeam,
    required this.onSave,
    required this.onDeleteUser,
  }) : super(equals: [
          formControllerTeam,
        ]);
}

class FormControllerTeam {
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  TeamModel teamModel;
  FormControllerTeam({
    required this.teamModel,
  });
  String? validateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'This field cannot be empty.' : null;
  void onChange({
    String? name,
    bool? isArchived,
    bool? isDeleted,
  }) {
    teamModel = teamModel.copyWith(
      name: name,
      isArchived: isArchived,
      isDeleted: isDeleted,
    );
  }

  void onCheckValidation() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      isFormValid = true;
    }
  }
}
