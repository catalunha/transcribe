// import 'package:async_redux/async_redux.dart';
// import 'package:fast_immutable_collections/fast_immutable_collections.dart';
// import 'package:flutter/material.dart';
// import 'package:transcribe/task/controller/task_model.dart';
// import 'package:transcribe/task/controller/task_action.dart';
// import 'package:transcribe/task/controller/task_model.dart';

// import '../../app_state.dart';
// import '../transcription_list.dart';
// import 'transcription_action.dart';

// class TranscriptionListConnector extends StatelessWidget {
//   const TranscriptionListConnector({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, TranscriptionListVm>(
//       vm: () => TranscriptionListVmFactory(this),
//       onInit: (store) {
//         store.dispatch(StreamDocsTranscriptionAction());
//       },
//       builder: (context, vm) => TranscriptionList(
//         taskIList: vm.taskIList,
//         userId: vm.userId,
//       ),
//     );
//   }
// }

// class TranscriptionListVmFactory
//     extends VmFactory<AppState, TranscriptionListConnector> {
//   TranscriptionListVmFactory(widget) : super(widget);
//   @override
//   TranscriptionListVm fromStore() => TranscriptionListVm(
//         taskIList: state.taskState.taskIList!,
//         userId: state.userState.userCurrent!.id,
//       );
// }

// class TranscriptionListVm extends Vm {
//   final IList<TaskModel> taskIList;
//   final String userId;
//   TranscriptionListVm({
//     required this.taskIList,
//     required this.userId,
//   }) : super(equals: [
//           taskIList,
//           userId,
//         ]);
// }
