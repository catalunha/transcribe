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
      onDispose: (store) {
        store.dispatch(SetNulTeamCurrentTeamAction());
      },
      vm: () => TeamAddEditFactory(this),
      builder: (context, vm) => TeamAddEdit(
        addOrEditId: addOrEditId,
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
          teamModel = teamModel.copyWith(isDeleted: teamModel.isDeleted);
          if (widget!.addOrEditId.isEmpty) {
            dispatch(AddDocTeamAction(teamModel: teamModel));
          } else {
            dispatch(UpdateDocTeamAction(teamModel: teamModel));
          }
        },
        onDeleteUser: (String userId) {
          dispatch(DeleteUserTeamAction(userId: userId));
        },
      );
}

class TeamAddEditVm extends Vm {
  final FormControllerTeam formControllerTeam;
  final Function(TeamModel) onSave;
  final Function(String) onDeleteUser;

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
  bool isFieldsExtraValid = false;
  bool? isUserMapValid;
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

  onFieldExtraValidation() {
    if (teamModel.userMap.isNotEmpty) {
      isUserMapValid = true;
    } else {
      isUserMapValid = false;
    }
    isFieldsExtraValid = (isUserMapValid ?? false);
  }

  void onCheckValidation() async {
    final form = formKey.currentState;

    if (form!.validate()) {
      isFormValid = true;
    }
  }
}
