import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:transcribe/widget/input_checkbox_delete.dart';
import 'package:transcribe/widget/input_title.dart';
import 'package:transcribe/search_user/search_user.dart';
import 'package:transcribe/widget/required_inform.dart';

import 'controller/team_addedit_connector.dart';
import 'controller/team_model.dart';

class TeamAddEdit extends StatefulWidget {
  final String addOrEditId;
  final FormControllerTeam formControllerTeam;
  final Function(TeamModel) onSave;
  final Function(String) onDeleteUser;

  const TeamAddEdit({
    Key? key,
    required this.formControllerTeam,
    required this.onSave,
    required this.onDeleteUser,
    required this.addOrEditId,
  }) : super(key: key);

  @override
  _TeamAddEditState createState() => _TeamAddEditState();
}

class _TeamAddEditState extends State<TeamAddEdit> {
  late FormControllerTeam formControllerTeam;
  bool invalidUserMap = false;
  @override
  void initState() {
    super.initState();
    formControllerTeam = widget.formControllerTeam;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.addOrEditId.isEmpty ? 'Add team.' : 'Edit team.'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formControllerTeam.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InputTitle(
                label: 'Name for the team',
                required: true,
                initialValue: formControllerTeam.teamModel.name,
                validator: formControllerTeam.validateRequiredText,
                onChanged: (value) {
                  formControllerTeam.onChange(name: value);
                },
              ),
              SearchUser(
                label: 'Select people for this team',
                userRefList:
                    formControllerTeam.teamModel.userMap.values.toList(),
                required: true,
                onDeleteUser: (String value) {
                  widget.onDeleteUser(value);
                },
                search: () async {
                  Navigator.pushNamed(
                    context,
                    '/search_user_list',
                  );
                },
                isFieldValid: widget.formControllerTeam.isUserMapValid,
              ),
              // widget.formControllerTeam.hasInvalidFields
              //     ? Text('${formControllerTeam.validateRequiredText("")}')
              //     : Container(),
              // formControllerTeam.teamModel.id.isEmpty
              //     ? Container()
              //     : InputCheckBox(
              //         title: 'Archived this team',
              //         subtitle: 'Select to archive this team.',
              //         icon: AppIconData.inbox,
              //         value: formControllerTeam.teamModel.isArchived,
              //         onChanged: (value) {
              //           formControllerTeam.onChange(isArchived: value);
              //           setState(() {});
              //         },
              //       ),
              widget.addOrEditId.isEmpty
                  ? Container()
                  : InputCheckBoxDelete(
                      title: 'Delete this team:',
                      subtitle: 'Delete forever',
                      value: formControllerTeam.teamModel.isDeleted,
                      onChanged: (value) {
                        formControllerTeam.onChange(isDeleted: value);
                        setState(() {});
                      },
                    ),
              RequiredInForm(
                message: 'team id: ${formControllerTeam.teamModel.id}',
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save this data in cloud',
        child: const Icon(AppIconData.saveInCloud),
        onPressed: () {
          formControllerTeam.onCheckValidation();
          widget.formControllerTeam.onFieldExtraValidation();
          setState(() {});

          if (formControllerTeam.isFormValid &&
              widget.formControllerTeam.isFieldsExtraValid) {
            Navigator.pop(context);
            widget.onSave(formControllerTeam.teamModel);
          }
        },
      ),
    );
  }
}
