import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/transcription/controller/transcription_action.dart';

import '../../app_state.dart';
import '../transcription_edit.dart';

class TranscriptionEditConnector extends StatelessWidget {
  final String addOrEditId;
  const TranscriptionEditConnector({
    Key? key,
    required this.addOrEditId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TranscriptionEditVm>(
      onInit: (store) {
        store.dispatch(
            SetTranscriptionCurrentTranscriptionAction(id: addOrEditId));
      },
      onDispose: (store) {
        store.dispatch(SetNulTranscriptioCurrentTeamAction());
      },
      vm: () => TranscriptionEditFactory(this),
      builder: (context, vm) => TranscriptionEdit(
        phraseAudio: vm.phraseAudio,
        isWritten: vm.isWritten,
        phraseWritten: vm.phraseWritten,
        phraseOrdered: vm.phraseOrdered,
        phraseList: vm.phraseList,
        onPhraseOrdering: vm.onPhraseOrdering,
        onPhraseTyping: vm.onPhraseTyping,
        onSave: vm.onSave,
      ),
    );
  }
}

class TranscriptionEditFactory
    extends VmFactory<AppState, TranscriptionEditConnector> {
  TranscriptionEditFactory(widget) : super(widget);
  @override
  TranscriptionEditVm fromStore() => TranscriptionEditVm(
        phraseAudio: state
            .transcriptionState.transcriptionCurrent!.task.phrase!.phraseAudio,
        phraseList: state
            .transcriptionState.transcriptionCurrent!.task.phrase!.phraseList,
        phraseOrdered:
            state.transcriptionState.transcriptionCurrent!.phraseOrdered!,
        isWritten:
            state.transcriptionState.transcriptionCurrent!.task.isWritten,
        phraseWritten:
            state.transcriptionState.transcriptionCurrent!.phraseWritten!,
        onPhraseOrdering: (List<String> newOrder) {
          dispatch(PhraseOrderingTranscriptionAction(newOrder: newOrder));
        },
        onPhraseTyping: (String text) {
          dispatch(PhraseTypingTranscriptionAction(text: text));
        },
        onSave: () {
          dispatch(UpdateDocTranscriptionAction());
        },
      );

  // List<String> disorderPhrase() {
  //   String userId = state.userState.userCurrent!.id;

  //   Transcription transcription =
  //       state.taskState.taskCurrent!.transcriptionMap![userId]!;
  //   return transcription.phraseOrdered!;
  // }
}

class TranscriptionEditVm extends Vm {
  final List<String> phraseList;
  final bool isWritten;
  final List<String> phraseOrdered;
  final String phraseWritten;
  final String phraseAudio;
  final Function(List<String>) onPhraseOrdering;
  final Function(String) onPhraseTyping;
  final Function() onSave;
  TranscriptionEditVm({
    required this.phraseList,
    required this.isWritten,
    required this.phraseOrdered,
    required this.phraseWritten,
    required this.phraseAudio,
    required this.onPhraseOrdering,
    required this.onPhraseTyping,
    required this.onSave,
  }) : super(equals: [
          phraseList,
          isWritten,
          phraseOrdered,
          phraseWritten,
          phraseAudio,
        ]);
}
