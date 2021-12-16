import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/modules/phrase/phrase_controller.dart';
import 'package:transcribe/app/modules/upload/upload_widget.dart';
import 'package:transcribe/app/theme/app_icon.dart';
import 'package:transcribe/app/widget/delete_document.dart';
import 'package:transcribe/app/widget/input_description.dart';
import 'package:transcribe/app/widget/input_title.dart';
import 'package:transcribe/app/widget/required_id.dart';

class PhraseAddEdit extends GetView<PhraseController> {
  const PhraseAddEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${controller.addOrEdit ? "Add" : "Edit"} sentence.'),
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
                    label: 'Group for this sentence',
                    required: true,
                    initialValue: controller.model.group,
                    validator: controller.formValidateRequiredText,
                    onChanged: (value) {
                      controller.onChangeModel(group: value);
                    },
                  ),
                  InputDescription(
                    label: 'Input the sentence. One word or symbol by line',
                    required: true,
                    initialValue: controller.model.phraseList.join('\n'),
                    validator: controller.formValidateRequiredText,
                    onChanged: (value) {
                      controller.onChangeModel(phrase: value);
                    },
                  ),
                ],
              ),
            ),
            UploadWidget(
              label: 'Send the audio',
              requiredField: true,
              initialUrl: controller.model.phraseAudio,
              pathInFirestore:
                  '${controller.model.teacher.id}/${controller.model.id}',
              getUrl: (url) {
                controller.onChangeModel(phraseAudio: url);
              },
            ),
            controller.addOrEdit
                ? Container()
                : DeleteDocument(
                    onPressed: controller.delete,
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
