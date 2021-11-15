import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/task/controller/task_action.dart';
import 'package:transcribe/phrase/controller/phrase_action.dart';
import 'package:transcribe/phrase/controller/phrase_model.dart';

import '../../app_state.dart';
import '../search_phrase_list.dart';

class SearchPhraseListConnector extends StatelessWidget {
  const SearchPhraseListConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PhraseListVm>(
      vm: () => PhraseListVmFactory(this),
      onInit: (store) {
        if (store.state.phraseState.phraseIList?.isEmpty ?? false) {
          store.dispatch(StreamDocsPhraseAction(isArchived: null));
        }
      },
      builder: (context, vm) => SearchPhraseList(
        phraseIList: vm.phraseIList,
        onSetPhrase: vm.onSetPhrase,
      ),
    );
  }
}

class PhraseListVmFactory
    extends VmFactory<AppState, SearchPhraseListConnector> {
  PhraseListVmFactory(widget) : super(widget);
  @override
  PhraseListVm fromStore() => PhraseListVm(
        phraseIList: state.phraseState.phraseIList!,
        onSetPhrase: (String phraseId) {
          dispatch(
            SetPhraseTaskAction(phraseId: phraseId),
          );
        },
      );
}

class PhraseListVm extends Vm {
  final IList<PhraseModel> phraseIList;
  final Function(String) onSetPhrase;

  PhraseListVm({
    required this.phraseIList,
    required this.onSetPhrase,
  }) : super(equals: [
          phraseIList,
        ]);
}
