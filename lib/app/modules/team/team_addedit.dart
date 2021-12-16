import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/modules/search_user/search_user_widget.dart';
import 'package:transcribe/app/theme/app_icon.dart';
import 'package:transcribe/app/widget/delete_document.dart';
import 'package:transcribe/app/widget/input_title.dart';
import 'package:transcribe/app/widget/required_id.dart';

import 'team_controller.dart';

class TeamAddEdit extends GetView<TeamController> {
  const TeamAddEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.addOrEdit ? "Add" : "Edit"} team.'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputTitle(
                    label: 'Name for the team',
                    required: true,
                    initialValue: controller.model.name,
                    validator: controller.formValidateRequiredText,
                    onChanged: (value) {
                      controller.onChangeModel(name: value);
                    },
                  ),
                ],
              ),
            ),
            SearchUserWidget(
              label: Obx(() => Text(
                    '${controller.model.students.length} Students. Click here, for select more.',
                    softWrap: true,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  )),
              // userRefList: controller.model.students.values.toList(),
              required: true,
              onDeleteUser: (String value) {
                controller.removeStudent(value);
              },
              search: () async {
                await Get.toNamed('/searchUser');
              },
            ),
            controller.addOrEdit
                ? Container()
                : DeleteDocument(
                    onPressed: controller.delete,
                  ),
            RequiredId(
              message: 'ID: ${controller.model.id}',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save this data in cloud',
        child: const Icon(AppIconData.saveInCloud),
        onPressed: () {
          controller.formSubmit();
        },
      ),
    );
  }
}
