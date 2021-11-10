// import 'package:async_redux/async_redux.dart';
// import 'package:flutter/material.dart';

// import 'package:classfrase/app_state.dart';

// import '../phrase_addedit_page.dart';
// import 'phrase_action.dart';
// import 'phrase_model.dart';

// class PhraseAddEditConnector extends StatelessWidget {
//   final String addOrEditId;
//   const PhraseAddEditConnector({
//     Key? key,
//     required this.addOrEditId,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, PhraseAddEditVm>(
//       onInit: (store) {
//         store.dispatch(SetPhraseCurrentPhraseAction(id: addOrEditId));
//       },
//       vm: () => PhraseAddEditFactory(this),
//       builder: (context, vm) => PhraseAddEditPage(
//         phraseCurrentIsPublic: vm.phraseCurrentIsPublic,
//         publicPhraseQuota: vm.publicPhraseQuota,
//         publicPhraseAmount: vm.publicPhraseAmount,
//         formController: vm.formController,
//         onSave: vm.onSave,
//       ),
//     );
//   }
// }

// class PhraseAddEditFactory extends VmFactory<AppState, PhraseAddEditConnector> {
//   PhraseAddEditFactory(widget) : super(widget);
//   @override
//   PhraseAddEditVm fromStore() => PhraseAddEditVm(
//         formController:
//             FormController(phraseModel: state.phraseState.phraseCurrent!),
//         onSave: (PhraseModel phraseModel) async {
//           if (widget!.addOrEditId.isEmpty) {
//             await dispatch(CreateDocPhraseAction(phraseModel: phraseModel));
//           } else {
//             await dispatch(UpdateDocPhraseAction(phraseModel: phraseModel));
//           }
//         },
//         publicPhraseQuota: state.userState.userCurrent!.publicPhraseQuota,
//         publicPhraseAmount: state.phraseState.publicPhraseAmount!,
//         phraseCurrentIsPublic: state.phraseState.phraseCurrent!.isPublic,
//       );
// }

// class PhraseAddEditVm extends Vm {
//   final bool phraseCurrentIsPublic;
//   final int publicPhraseQuota;
//   final int publicPhraseAmount;
//   final FormController formController;
//   final Function(PhraseModel) onSave;

//   PhraseAddEditVm({
//     required this.phraseCurrentIsPublic,
//     required this.publicPhraseQuota,
//     required this.publicPhraseAmount,
//     required this.formController,
//     required this.onSave,
//   }) : super(equals: [
//           phraseCurrentIsPublic,
//           publicPhraseQuota,
//           publicPhraseAmount,
//           formController,
//         ]);
// }

// class FormController {
//   final formKey = GlobalKey<FormState>();
//   bool isFormValid = false;
//   PhraseModel phraseModel;
//   FormController({
//     required this.phraseModel,
//   });
//   String? validateRequiredText(String? value) =>
//       value?.isEmpty ?? true ? 'Este campo não pode ser vazio.' : null;
//   void onChange({
//     String? phrase,
//     String? font,
//     String? description,
//     String? observer,
//     bool? isArchived,
//     bool? isPublic,
//     bool? isDeleted,
//   }) {
//     phraseModel = phraseModel.copyWith(
//       phrase: phrase,
//       font: font,
//       description: description,
//       observer: observer,
//       isArchived: isArchived,
//       isPublic: isPublic,
//       isDeleted: isDeleted,
//     );
//   }

//   void onCheckValidation() async {
//     final form = formKey.currentState;
//     if (form!.validate()) {
//       isFormValid = true;
//     }
//   }
// }
