import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/modules/search_phrase/search_phrase_widget.dart';
import 'package:transcribe/app/modules/search_team/search_team_widget.dart';
import 'package:transcribe/app/modules/task/task_controller.dart';
import 'package:transcribe/app/modules/team/team_card.dart';
import 'package:transcribe/app/theme/app_icon.dart';
import 'package:transcribe/app/widget/input_checkbox.dart';
import 'package:transcribe/app/widget/input_title.dart';
import 'package:transcribe/app/widget/required_id.dart';

class TaskAddEdit extends GetView<TaskController> {
  const TaskAddEdit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.addOrEdit ? "Add" : "Edit"} task.'),
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
                    label: 'Name for the task',
                    required: true,
                    initialValue: controller.model.title,
                    validator: controller.formValidateRequiredText,
                    onChanged: (value) {
                      controller.onChangeModel(title: value);
                    },
                  ),
                  Obx(
                    () => InputCheckBox(
                      title: 'Write the sentence instead of ordering',
                      subtitle:
                          'if checked. student must write the sentence. not ordering.',
                      icon: AppIconData.check,
                      value: controller.model.isWritten,
                      onChanged: (value) {
                        controller.onChangeModel(isWritten: value);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SearchTeamWidget(
              label: 'Select team for this task',
              teamWidget: Obx(
                () {
                  if (controller.model.team != null) {
                    return TeamCard(
                      team: controller.model.team,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              required: true,
            ),
            SearchPhraseWidget(
              label: 'Select phrase for this task',
              phraseWidget: Obx(
                () {
                  if (controller.model.phrase != null) {
                    return ListTile(
                      title: Text(controller.model.phrase.phraseList.join(' ')),
                      subtitle: Text(controller.model.phrase.group),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              required: true,
            ),
            RequiredId(
              message: 'Sentence id: ${controller.model.id}',
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
