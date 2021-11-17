import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/upload/controller/upload_action.dart';
import '../../app_state.dart';
import '../../routes.dart';
import '../phrase_addedit.dart';
import 'phrase_action.dart';
import 'phrase_model.dart';

class PhraseAddEditConnector extends StatelessWidget {
  final ArgumentsRoutes addOrEditId;
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
      onDispose: (store) {
        store.dispatch(SetNulPhraseCurrentPhraseAction());
      },
      vm: () => PhraseAddEditFactory(this),
      builder: (context, vm) => PhraseAddEdit(
        addOrEditId: addOrEditId.args[0] == 'add' ? true : false,
        formControllerPhrase: vm.formControllerPhrase,
        onSave: vm.onSave,
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
            if (widget!.addOrEditId.args[0] == 'add') {
              await dispatch(CreateDocPhraseAction(phraseModel: phraseModel));
            } else {
              await dispatch(UpdateDocPhraseAction(phraseModel: phraseModel));
            }
            dispatch(NavigateAction.pop());
          }
        },
      );
}

class PhraseAddEditVm extends Vm {
  final FormControllerPhase formControllerPhrase;
  final Function(PhraseModel) onSave;

  PhraseAddEditVm({
    required this.formControllerPhrase,
    required this.onSave,
  }) : super(equals: [
          formControllerPhrase,
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
    // bool? isArchived,
    // bool? isDeleted,
  }) {
    phraseModel = phraseModel.copyWith(
      phraseList: phrase?.split('\n'),
      group: group,
      // phraseAudio: phraseAudio,
      // isArchived: isArchived,
      // isDeleted: isDeleted,
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
