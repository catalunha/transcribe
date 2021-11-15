import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:transcribe/task/controller/task_action.dart';
import 'package:transcribe/task/controller/task_model.dart';

import '../../app_state.dart';
import 'transcription_model.dart';

// class StreamDocsTranscriptionAction extends ReduxAction<AppState> {
//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     Query<Map<String, dynamic>> collRef;
//     collRef = firebaseFirestore
//         .collection(TaskModel.collection)
//         .where('team.userList', arrayContains: state.userState.userCurrent!.id)
//         .where('isArchivedByStudent', isEqualTo: false)
//         .where('isDeleted', isEqualTo: false);

//     Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
//         collRef.snapshots();

//     Stream<List<TaskModel>> streamList = streamQuerySnapshot.map(
//         (querySnapshot) => querySnapshot.docs
//             .map((docSnapshot) => TaskModel.fromMap(docSnapshot.data()))
//             .toList());
//     streamList.listen((List<TaskModel> taskModelList) {
//       dispatch(SetTaskListTaskAction(
//           taskList: IList(taskModelList).withConfig(
//               ConfigList(isDeepEquals: false, cacheHashCode: false))));
//     });

//     return null;
//   }
// }

class SetTranscriptionListTaskAction extends ReduxAction<AppState> {
  final IList<TranscriptionModel> transcriptionIList;

  SetTranscriptionListTaskAction({required this.transcriptionIList});
  @override
  AppState reduce() {
    return state.copyWith(
      transcriptionState: state.transcriptionState.copyWith(
        transcriptionIList: transcriptionIList,
      ),
    );
  }

  // @override
  // void after() {
  //   super.after();

  //   if (state.taskState.taskCurrent != null) {
  //     dispatch(SetTaskCurrentTaskAction(id: state.taskState.taskCurrent!.id));
  //     // print('SetTaskListTaskAction.after: ${state.taskState.taskCurrent}');
  //   }
  // }
}


// class ResetPhraseCurrentTranscriptionAction extends ReduxAction<AppState> {
//   ResetPhraseCurrentTranscriptionAction();
//   @override
//   AppState reduce() {
//     final String phraseCurrentId = state.taskState.taskCurrent!.id;

//     TaskModel taskModel;
//     taskModel = state.taskState.taskIList!
//         .firstWhere((element) => element.id == phraseCurrentId)
//         .copy();

//     return state.copyWith(
//       taskState: state.taskState.copyWith(
//         taskCurrent: taskModel,
//       ),
//     );
//   }
// }

// class SetTaskCurrentTranscriptionAction extends ReduxAction<AppState> {
//   final String id;
//   SetTaskCurrentTranscriptionAction({
//     required this.id,
//   });

//   @override
//   AppState reduce() {
//     TaskModel taskModel = state.taskState.taskIList!
//         .firstWhere((element) => element.id == id)
//         .copy();

//     if (taskModel.transcriptionMap == null) {
//       taskModel =
//           taskModel.copyWith(transcriptionMap: <String, Transcription>{});
//     }

//     String userId = state.userState.userCurrent!.id;
//     if (!taskModel.transcriptionMap!.containsKey(userId)) {
//       List<String> temp = taskModel.phrase!.phraseList;
//       temp.sort();
//       Transcription transcription = Transcription(
//         phraseOrdered: temp,
//       );
//       Map<String, Transcription> transcriptionMapTemp =
//           taskModel.transcriptionMap!; //<userId,Transcription
//       transcriptionMapTemp.addAll({userId: transcription});
//       taskModel = taskModel.copyWith(transcriptionMap: transcriptionMapTemp);
//     }
//     return state.copyWith(
//       taskState: state.taskState.copyWith(
//         taskCurrent: taskModel,
//       ),
//     );
//   }
// }

// class SetNewOrderTranscriptionAction extends ReduxAction<AppState> {
//   final List<String> newOrder;
//   SetNewOrderTranscriptionAction({
//     required this.newOrder,
//   });
//   @override
//   before() {
//     for (var task in state.taskState.taskIList!) {
//       print('SetNewOrderTranscriptionAction.before list : $task');
//     }
//     print(
//         'SetNewOrderTranscriptionAction.before current: ${state.taskState.taskCurrent}');
//   }

//   @override
//   AppState reduce() {
//     String userId = state.userState.userCurrent!.id;
//     TaskModel taskModel = state.taskState.taskCurrent!;
//     print('SetNewOrderTranscriptionAction model: $taskModel');
//     Map<String, Transcription>? transcriptionMapTemp =
//         taskModel.transcriptionMap;
//     Transcription transcription =
//         transcriptionMapTemp![userId]!.copyWith(phraseOrdered: newOrder);

//     transcriptionMapTemp[userId] = transcription;

//     taskModel = taskModel.copyWith(transcriptionMap: transcriptionMapTemp);
//     // taskModel.transcriptionMap![userId]!.phraseOrdered = newOrder;
//     print('SetNewOrderTranscriptionAction model 2: $taskModel');

//     return state.copyWith(
//       taskState: state.taskState.copyWith(
//         taskCurrent: taskModel,
//       ),
//     );
//   }

//   @override
//   void after() {
//     // super.after();
//     for (var task in state.taskState.taskIList!) {
//       print('SetNewOrderTranscriptionAction.after list : $task');
//     }
//     print(
//         'SetNewOrderTranscriptionAction.after current: ${state.taskState.taskCurrent!}');
//   }
// }

// class UpdateDocTranscriptionAction extends ReduxAction<AppState> {
//   UpdateDocTranscriptionAction();

//   @override
//   Future<AppState?> reduce() async {
//     TaskModel taskModel = state.taskState.taskCurrent!.copyWith();
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     DocumentReference docRef =
//         firebaseFirestore.collection(TaskModel.collection).doc(taskModel.id);
//     String userId = state.userState.userCurrent!.id;
//     Transcription transcription = taskModel.transcriptionMap![userId]!;
// //TODO
// // remover da lista
//     // dispatch(SetTaskCurrentTaskAction(id: ''));

//     await docRef.update({
//       'transcriptionMap': {userId: transcription.toMap()}
//     });

//     return null;
//   }
// }
