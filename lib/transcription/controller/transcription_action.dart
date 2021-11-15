import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';

import '../../app_state.dart';
import 'transcription_model.dart';

class StreamDocsTranscriptionAction extends ReduxAction<AppState> {
  final bool isArchived;

  StreamDocsTranscriptionAction({required this.isArchived});
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(TranscriptionModel.collection)
        .where('student.id', isEqualTo: state.userState.userCurrent!.id)
        .where('isArchived', isEqualTo: isArchived);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<TranscriptionModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map(
                (docSnapshot) => TranscriptionModel.fromMap(docSnapshot.data()))
            .toList());
    streamList.listen((List<TranscriptionModel> transcriptionList) {
      if (isArchived) {
        dispatch(SetTranscriptionListArchivedTranscriptionAction(
            transcriptionIList: IList(transcriptionList)));
      } else {
        dispatch(SetTranscriptionListTranscriptionAction(
            transcriptionIList: IList(transcriptionList)));
      }
    });

    return null;
  }
}

class SetTranscriptionListTranscriptionAction extends ReduxAction<AppState> {
  final IList<TranscriptionModel> transcriptionIList;

  SetTranscriptionListTranscriptionAction({required this.transcriptionIList});
  @override
  AppState reduce() {
    return state.copyWith(
      transcriptionState: state.transcriptionState.copyWith(
        transcriptionIList: transcriptionIList,
      ),
    );
  }

  @override
  void after() {
    super.after();
    dispatch(ViewTranscriptionListTranscriptionAction());
    // if (state.transcriptionState.transcriptionCurrent != null) {
    //   dispatch(SetTranscriptionCurrentTranscriptionAction(id: state.taskState.taskCurrent!.id));
    //   // print('SetTaskListTaskAction.after: ${state.taskState.taskCurrent}');
    // }
  }
}

class ViewTranscriptionListTranscriptionAction extends ReduxAction<AppState> {
  @override
  AppState? reduce() {
    print('TranscriptionList: ${state.transcriptionState.transcriptionIList}');
    return null;
  }
}

class SetTranscriptionListArchivedTranscriptionAction
    extends ReduxAction<AppState> {
  final IList<TranscriptionModel> transcriptionIList;

  SetTranscriptionListArchivedTranscriptionAction(
      {required this.transcriptionIList});
  @override
  AppState reduce() {
    return state.copyWith(
      transcriptionState: state.transcriptionState.copyWith(
        transcriptionIListArchived: transcriptionIList,
      ),
    );
  }

  @override
  void after() {
    super.after();
    dispatch(ViewTranscriptionListArchivedTranscriptionAction());
    // if (state.transcriptionState.transcriptionCurrent != null) {
    //   dispatch(SetTranscriptionCurrentTranscriptionAction(id: state.taskState.taskCurrent!.id));
    //   // print('SetTaskListTaskAction.after: ${state.taskState.taskCurrent}');
    // }
  }
}

class ViewTranscriptionListArchivedTranscriptionAction
    extends ReduxAction<AppState> {
  @override
  AppState? reduce() {
    print(
        'transcriptionIListArchived: ${state.transcriptionState.transcriptionIListArchived}');
    return null;
  }
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

class SetTranscriptionCurrentTranscriptionAction extends ReduxAction<AppState> {
  final String id;
  SetTranscriptionCurrentTranscriptionAction({
    required this.id,
  });

  @override
  AppState reduce() {
    TranscriptionModel transcriptionModel = state
        .transcriptionState.transcriptionIList!
        .firstWhere((element) => element.id == id)
        .copy();

    // if (transcriptionModel.transcriptionMap == null) {
    //   taskModel =
    //       taskModel.copyWith(transcriptionMap: <String, Transcription>{});
    // }

    // String userId = state.userState.userCurrent!.id;
    if (transcriptionModel.phraseOrdered!.isEmpty) {
      List<String> temp = transcriptionModel.task.phrase!.phraseList.toList();
      temp.sort();
      transcriptionModel = transcriptionModel.copyWith(phraseOrdered: temp);
    }
    return state.copyWith(
      transcriptionState: state.transcriptionState.copyWith(
        transcriptionCurrent: transcriptionModel,
      ),
    );
  }
}

class SetNewOrderTranscriptionAction extends ReduxAction<AppState> {
  final List<String> newOrder;
  SetNewOrderTranscriptionAction({
    required this.newOrder,
  });
  // @override
  // before() {
  //   for (var task in state.taskState.taskIList!) {
  //     print('SetNewOrderTranscriptionAction.before list : $task');
  //   }
  //   print(
  //       'SetNewOrderTranscriptionAction.before current: ${state.taskState.taskCurrent}');
  // }

  @override
  AppState reduce() {
    // String userId = state.userState.userCurrent!.id;
    TranscriptionModel transcriptionModel =
        state.transcriptionState.transcriptionCurrent!;
    // print('SetNewOrderTranscriptionAction model: $taskModel');
    // Map<String, Transcription>? transcriptionMapTemp =
    //     taskModel.transcriptionMap;
    // Transcription transcription =
    //     transcriptionMapTemp![userId]!.copyWith(phraseOrdered: newOrder);

    // transcriptionMapTemp[userId] = transcription;

    transcriptionModel = transcriptionModel.copyWith(phraseOrdered: newOrder);
    // taskModel.transcriptionMap![userId]!.phraseOrdered = newOrder;
    // print('SetNewOrderTranscriptionAction model 2: $taskModel');

    return state.copyWith(
      transcriptionState: state.transcriptionState.copyWith(
        transcriptionCurrent: transcriptionModel,
      ),
    );
  }

  // @override
  // void after() {
  //   // super.after();
  //   for (var task in state.taskState.taskIList!) {
  //     print('SetNewOrderTranscriptionAction.after list : $task');
  //   }
  //   print(
  //       'SetNewOrderTranscriptionAction.after current: ${state.taskState.taskCurrent!}');
  // }
}

class UpdateDocTranscriptionAction extends ReduxAction<AppState> {
  UpdateDocTranscriptionAction();

  @override
  Future<AppState?> reduce() async {
    TranscriptionModel transcriptionModel =
        state.transcriptionState.transcriptionCurrent!;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(TranscriptionModel.collection)
        .doc(transcriptionModel.id);

    bool orderedSolved = false;
    orderedSolved = listEquals(transcriptionModel.task.phrase!.phraseList,
        transcriptionModel.phraseOrdered);
    bool writtenSolved = false;
    writtenSolved = transcriptionModel.task.phrase!.phraseList.join(' ') ==
        transcriptionModel.phraseWritten;
    transcriptionModel =
        transcriptionModel.copyWith(isSolved: orderedSolved || writtenSolved);

    // Transcription transcription = taskModel.transcriptionMap![userId]!;
//TODO
// remover da lista
    // dispatch(SetTaskCurrentTaskAction(id: ''));

    await docRef.update(transcriptionModel.toMap());

    return null;
  }
}

class ArchiveDocTranscriptionAction extends ReduxAction<AppState> {
  final String transcriptionId;
  final bool isArchived;

  ArchiveDocTranscriptionAction({
    required this.transcriptionId,
    this.isArchived = true,
  });

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(TranscriptionModel.collection)
        .doc(transcriptionId);

    // dispatch(SetTaskCurrentTaskAction(id: null));

    await docRef.update({'isArchived': isArchived});

    return null;
  }
}

class DeleteDocTranscriptionAction extends ReduxAction<AppState> {
  final String transcriptionId;

  DeleteDocTranscriptionAction({required this.transcriptionId});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(TranscriptionModel.collection)
        .doc(transcriptionId);

    await docRef.delete();

    return null;
  }
}
