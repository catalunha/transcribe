import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/upload/controller/upload_action.dart';
import 'package:transcribe/upload/controller/upload_state.dart';
import '../../app_state.dart';
import '../phrase_addedit.dart';
import 'phrase_action.dart';
import 'phrase_model.dart';

class PhraseAddEditConnector extends StatelessWidget {
  final String addOrEditId;
  const PhraseAddEditConnector({
    Key? key,
    required this.addOrEditId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PhraseAddEditVm>(
      onInit: (store) {
        store.dispatch(SetPhraseCurrentPhraseAction(id: addOrEditId));
        store.dispatch(RestartingStateUploadAction());
        if (store.state.phraseState.phraseCurrent!.phraseAudio.isNotEmpty) {
          store.dispatch(SetUrlForDownloadUploadAction(
              url: store.state.phraseState.phraseCurrent!.phraseAudio));
        }
      },
      vm: () => PhraseAddEditFactory(this),
      builder: (context, vm) => PhraseAddEdit(
        formControllerPhrase: vm.formControllerPhrase,
        onSave: vm.onSave,
        addOrEditId: vm.addOrEditId,
      ),
    );
  }
}

class PhraseAddEditFactory extends VmFactory<AppState, PhraseAddEditConnector> {
  PhraseAddEditFactory(widget) : super(widget);
  @override
  PhraseAddEditVm fromStore() => PhraseAddEditVm(
        formControllerPhrase:
            FormControllerPhase(phraseModel: state.phraseState.phraseCurrent!),
        onSave: (PhraseModel phraseModel) async {
          if (state.uploadState.urlForDownload != null &&
              state.uploadState.urlForDownload!.isNotEmpty) {
            phraseModel = phraseModel.copyWith(
                phraseAudio: state.uploadState.urlForDownload);
          }
          if (widget!.addOrEditId.isEmpty) {
            await dispatch(CreateDocPhraseAction(phraseModel: phraseModel));
          } else {
            await dispatch(UpdateDocPhraseAction(phraseModel: phraseModel));
          }
        },
        addOrEditId: widget!.addOrEditId.isEmpty,
      );
}

class PhraseAddEditVm extends Vm {
  final FormControllerPhase formControllerPhrase;
  final Function(PhraseModel) onSave;
  final bool addOrEditId;

  PhraseAddEditVm({
    required this.formControllerPhrase,
    required this.onSave,
    required this.addOrEditId,
  }) : super(equals: [
          formControllerPhrase,
          addOrEditId,
        ]);
}

class FormControllerPhase {
  final formKey = GlobalKey<FormState>();
  bool isFormValid = false;
  PhraseModel phraseModel;
  FormControllerPhase({
    required this.phraseModel,
  });
  String? validateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'This field cannot be empty.' : null;
  void onChange({
    String? phrase,
    String? group,
    // String? phraseAudio,
    bool? isArchived,
    bool? isDeleted,
  }) {
    phraseModel = phraseModel.copyWith(
      phraseList: phrase?.split('\n'),
      group: group,
      // phraseAudio: phraseAudio,
      isArchived: isArchived,
      isDeleted: isDeleted,
    );
    // // print('==--> FormController.onChange: $phraseModel');
  }

  void onCheckValidation() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      isFormValid = true;
    }
  }
}
