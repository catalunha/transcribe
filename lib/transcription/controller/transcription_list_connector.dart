import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';

import '../../app_state.dart';
import '../transcription_list.dart';
import 'transcription_action.dart';
import 'transcription_model.dart';

class TranscriptionListConnector extends StatelessWidget {
  const TranscriptionListConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TranscriptionListVm>(
      vm: () => TranscriptionListVmFactory(this),
      onInit: (store) {
        store.dispatch(StreamDocsTranscriptionAction(isArchived: false));
      },
      builder: (context, vm) => TranscriptionList(
        transcriptionIList: vm.transcriptionIList,
        onArchive: vm.onArchive,
      ),
    );
  }
}

class TranscriptionListVmFactory
    extends VmFactory<AppState, TranscriptionListConnector> {
  TranscriptionListVmFactory(widget) : super(widget);
  @override
  TranscriptionListVm fromStore() => TranscriptionListVm(
        transcriptionIList: state.transcriptionState.transcriptionIList!,
        onArchive: (String transcriptionId) {
          dispatch(
              ArchiveDocTranscriptionAction(transcriptionId: transcriptionId));
        },
      );
}

class TranscriptionListVm extends Vm {
  final IList<TranscriptionModel> transcriptionIList;
  final Function(String) onArchive;
  TranscriptionListVm({
    required this.transcriptionIList,
    required this.onArchive,
  }) : super(equals: [
          transcriptionIList,
        ]);
}
