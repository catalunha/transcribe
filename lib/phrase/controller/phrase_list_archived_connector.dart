import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/phrase/controller/phrase_action.dart';
import 'package:transcribe/phrase/controller/phrase_model.dart';
import '../../app_state.dart';
import '../phrase_list_archived.dart';

class PhraseListArchivedConnector extends StatelessWidget {
  const PhraseListArchivedConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PhraseArchivedPageVm>(
      vm: () => PhraseArchivedPageVmFactory(this),
      onInit: (store) {
        store.dispatch(StreamDocsPhraseAction(isArchived: true));
      },
      builder: (context, vm) => PhraseArchivedList(
        phraseIList: vm.phraseIList,
        onArchive: vm.onArchive,
        onDelete: vm.onDelete,
      ),
    );
  }
}

class PhraseArchivedPageVmFactory
    extends VmFactory<AppState, PhraseListArchivedConnector> {
  PhraseArchivedPageVmFactory(widget) : super(widget);
  @override
  PhraseArchivedPageVm fromStore() => PhraseArchivedPageVm(
        phraseIList: state.phraseState.phraseIListArchived!,
        onArchive: (String phraseId) {
          dispatch(
              ArchiveDocPhraseAction(phraseId: phraseId, isArchived: false));
        },
        onDelete: (String phraseId) {
          dispatch(DeleteDocPhraseAction(phraseId: phraseId));
        },
      );
}

class PhraseArchivedPageVm extends Vm {
  final IList<PhraseModel> phraseIList;
  final Function(String) onArchive;
  final Function(String) onDelete;

  PhraseArchivedPageVm({
    required this.phraseIList,
    required this.onArchive,
    required this.onDelete,
  }) : super(
          equals: [
            phraseIList,
          ],
        );
}
