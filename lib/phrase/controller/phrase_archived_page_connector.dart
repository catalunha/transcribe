// import 'package:async_redux/async_redux.dart';
// import 'package:classfrase/phrase/controller/phrase_action.dart';
// import 'package:classfrase/phrase/controller/phrase_model.dart';

// import 'package:flutter/material.dart';

// import '../../app_state.dart';
// import '../phrase_archived_page.dart';

// class PhraseArchivedPageConnector extends StatelessWidget {
//   const PhraseArchivedPageConnector({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, PhraseArchivedPageVm>(
//       vm: () => PhraseArchivedPageVmFactory(this),
//       onInit: (store) {
//         store.dispatch(ReadDocsPhraseAction(isArchived: true));
//       },
//       builder: (context, vm) => PhraseArchivedPage(
//         phraseList: vm.phraseList,
//         onUnArchivePhrase: vm.onUnArchivePhrase,
//       ),
//     );
//   }
// }

// class PhraseArchivedPageVmFactory
//     extends VmFactory<AppState, PhraseArchivedPageConnector> {
//   PhraseArchivedPageVmFactory(widget) : super(widget);
//   @override
//   PhraseArchivedPageVm fromStore() => PhraseArchivedPageVm(
//       phraseList: state.phraseState.phraseArchivedList!,
//       onUnArchivePhrase: (String phraseId) {
//         dispatch(UnArchivePhraseAction(phraseId: phraseId));
//       });
// }

// class PhraseArchivedPageVm extends Vm {
//   final List<PhraseModel> phraseList;
//   final Function(String) onUnArchivePhrase;
//   PhraseArchivedPageVm({
//     required this.phraseList,
//     required this.onUnArchivePhrase,
//   }) : super(equals: [
//           phraseList,
//         ]);
// }
