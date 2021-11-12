import 'package:async_redux/async_redux.dart';
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
        if (store.state.phraseState.phraseList?.isEmpty ?? false) {
          store.dispatch(StreamDocsPhraseAction());
        }
      },
      builder: (context, vm) => SearchPhraseList(
        phraseList: vm.phraseList,
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
        phraseList: state.phraseState.phraseList!,
        onSetPhrase: (String phraseId) {
          dispatch(
            SetPhraseTaskAction(phraseId: phraseId),
          );
        },
      );
}

class PhraseListVm extends Vm {
  final List<PhraseModel> phraseList;
  final Function(String) onSetPhrase;

  PhraseListVm({
    required this.phraseList,
    required this.onSetPhrase,
  }) : super(equals: [
          phraseList,
        ]);
}
