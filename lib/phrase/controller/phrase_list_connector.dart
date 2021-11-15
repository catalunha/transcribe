import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/phrase/controller/phrase_action.dart';
import 'package:transcribe/phrase/controller/phrase_model.dart';
import '../../app_state.dart';
import '../phrase_list.dart';

class PhraseListConnector extends StatelessWidget {
  const PhraseListConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PhraseArchivedPageVm>(
      vm: () => PhraseArchivedPageVmFactory(this),
      onInit: (store) {
        store.dispatch(StreamDocsPhraseAction(isArchived: false));
      },
      builder: (context, vm) => PhraseList(
        phraseIList: vm.phraseIList,
        onArchive: vm.onArchive,
      ),
    );
  }
}

class PhraseArchivedPageVmFactory
    extends VmFactory<AppState, PhraseListConnector> {
  PhraseArchivedPageVmFactory(widget) : super(widget);
  @override
  PhraseArchivedPageVm fromStore() => PhraseArchivedPageVm(
        phraseIList: state.phraseState.phraseIList!,
        onArchive: (String phraseId) {
          dispatch(ArchiveDocPhraseAction(phraseId: phraseId));
        },
      );
}

class PhraseArchivedPageVm extends Vm {
  final IList<PhraseModel> phraseIList;
  final Function(String) onArchive;

  PhraseArchivedPageVm({
    required this.phraseIList,
    required this.onArchive,
  }) : super(
          equals: [
            phraseIList,
          ],
        );
}
