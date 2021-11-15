import 'package:async_redux/async_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/task/controller/task_model.dart';
import 'package:transcribe/task/controller/task_action.dart';
import 'package:transcribe/task/controller/task_model.dart';

import '../../app_state.dart';
import '../transcription_list_archived.dart';
import 'transcription_action.dart';
import 'transcription_model.dart';

class TranscriptionListArchivedConnector extends StatelessWidget {
  const TranscriptionListArchivedConnector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TranscriptionListVm>(
      vm: () => TranscriptionListVmFactory(this),
      onInit: (store) {
        store.dispatch(StreamDocsTranscriptionAction(isArchived: true));
      },
      builder: (context, vm) => TranscriptionListArchived(
        transcriptionIList: vm.transcriptionIList,
        onArchive: vm.onArchive,
        onDelete: vm.onDelete,
      ),
    );
  }
}

class TranscriptionListVmFactory
    extends VmFactory<AppState, TranscriptionListArchivedConnector> {
  TranscriptionListVmFactory(widget) : super(widget);
  @override
  TranscriptionListVm fromStore() => TranscriptionListVm(
        transcriptionIList:
            state.transcriptionState.transcriptionIListArchived!,
        onArchive: (String transcriptionId) {
          dispatch(ArchiveDocTranscriptionAction(
              transcriptionId: transcriptionId, isArchived: false));
        },
        onDelete: (String transcriptionId) {
          dispatch(
              DeleteDocTranscriptionAction(transcriptionId: transcriptionId));
        },
      );
}

class TranscriptionListVm extends Vm {
  final IList<TranscriptionModel> transcriptionIList;
  final Function(String) onArchive;
  final Function(String) onDelete;
  TranscriptionListVm({
    required this.transcriptionIList,
    required this.onArchive,
    required this.onDelete,
  }) : super(equals: [
          transcriptionIList,
        ]);
}
