import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:transcribe/upload/controller/input_file_connector.dart';
import 'package:transcribe/widget/input_description.dart';
import 'package:transcribe/widget/input_title.dart';
import 'package:transcribe/widget/required_inform.dart';
import 'controller/phrase_addedit_connector.dart';
import 'controller/phrase_model.dart';

class PhraseAddEdit extends StatefulWidget {
  final FormControllerPhase formControllerPhrase;
  final Function(PhraseModel) onSave;
  final bool addOrEditId;

  const PhraseAddEdit({
    Key? key,
    required this.formControllerPhrase,
    required this.onSave,
    required this.addOrEditId,
  }) : super(key: key);

  @override
  _PhraseAddEditState createState() => _PhraseAddEditState();
}

class _PhraseAddEditState extends State<PhraseAddEdit> {
  late FormControllerPhase formControllerPhrase;

  // _PhraseAddEditState();
  @override
  void initState() {
    super.initState();
    formControllerPhrase = widget.formControllerPhrase;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.addOrEditId ? 'Add sentence.' : 'Edit sentence.'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formControllerPhrase.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputTitle(
                  label: 'Group for this sentence',
                  required: true,
                  validator: formControllerPhrase.validateRequiredText,
                  initialValue: formControllerPhrase.phraseModel.group,
                  onChanged: (value) {
                    formControllerPhrase.onChange(group: value);
                  },
                ),

                InputDescription(
                  label: 'Input the sentence',
                  required: true,
                  initialValue:
                      formControllerPhrase.phraseModel.phraseList.join('\n'),
                  validator: formControllerPhrase.validateRequiredText,
                  onChanged: (value) {
                    formControllerPhrase.onChange(phrase: value);
                  },
                ),
                const InputFileConnector(
                  label: 'Send the audio',
                  requiredField: true,
                ),

                // const Padding(
                //   padding: EdgeInsets.all(8.0),
                //   child: Text(
                //     'Observation: if the sentence for change. All imagens is deleted.',
                //     // style: TextStyle(color: ThemeApp.onBackground),
                //     textAlign: TextAlign.center,
                //   ),
                // ),

                // widget.addOrEditId
                //     ? Container()
                //     : InputCheckBox(
                //         title: 'Archived this sentence',
                //         subtitle: 'Select to archive this sentence.',
                //         icon: AppIconData.inbox,
                //         value: formControllerPhrase.phraseModel.isArchived,
                //         onChanged: (value) {
                //           formControllerPhrase.onChange(isArchived: value);
                //           setState(() {});
                //         },
                //       ),
                // widget.addOrEditId
                //     ? Container()
                //     : InputCheckBoxDelete(
                //         title: 'Delete this sentence',
                //         subtitle: 'Delete forever',
                //         value: formControllerPhrase.phraseModel.isDeleted,
                //         onChanged: (value) {
                //           formControllerPhrase.onChange(isDeleted: value);
                //           setState(() {});
                //         },
                //       ),
                RequiredInForm(
                  message:
                      'Sentence id: ${formControllerPhrase.phraseModel.id}',
                ),
              ],
            )),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save this data in cloud',
        child: const Icon(AppIconData.saveInCloud),
        onPressed: () {
          formControllerPhrase.onCheckValidation();
          if (formControllerPhrase.isFormValid) {
            // Navigator.pop(context);
            widget.onSave(formControllerPhrase.phraseModel);
          }
        },
      ),
    );
  }
}
