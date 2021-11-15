import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:transcribe/phrase/controller/phrase_model.dart';
import 'package:transcribe/team/controller/team_model.dart';
import 'package:transcribe/transcription/controller/transcription_action.dart';
import 'package:transcribe/transcription/controller/transcription_model.dart';
import 'package:transcribe/user/controller/user_model.dart';

import '../../app_state.dart';
import 'task_model.dart';

class StreamDocsTaskAction extends ReduxAction<AppState> {
  final bool isArchived;

  StreamDocsTaskAction({required this.isArchived});
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(TaskModel.collection)
        .where('team.teacher.id', isEqualTo: state.userState.userCurrent!.id)
        .where('isArchived', isEqualTo: isArchived);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<TaskModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) => TaskModel.fromMap(docSnapshot.data()))
            .toList());
    streamList.listen((List<TaskModel> taskModelList) {
      if (isArchived) {
        dispatch(SetTaskListArchivedTaskAction(taskList: IList(taskModelList)));
      } else {
        dispatch(SetTaskListTaskAction(taskList: IList(taskModelList)));
      }
    });

    return null;
  }
}

class SetTaskListTaskAction extends ReduxAction<AppState> {
  final IList<TaskModel> taskList;

  SetTaskListTaskAction({required this.taskList});
  @override
  AppState reduce() {
    taskList.sort((a, b) => a.title.compareTo(b.title));

    return state.copyWith(
      taskState: state.taskState.copyWith(
        taskIList: taskList,
      ),
    );
  }

  @override
  void after() {
    super.after();

    if (state.taskState.taskCurrent != null) {
      dispatch(SetTaskCurrentTaskAction(id: state.taskState.taskCurrent!.id));
      // print('SetTaskListTaskAction.after: ${state.taskState.taskCurrent}');
    }
  }
}

class SetTaskListArchivedTaskAction extends ReduxAction<AppState> {
  final IList<TaskModel> taskList;

  SetTaskListArchivedTaskAction({required this.taskList});
  @override
  AppState reduce() {
    taskList.sort((a, b) => a.title.compareTo(b.title));

    return state.copyWith(
      taskState: state.taskState.copyWith(
        taskIListArchived: taskList,
      ),
    );
  }
}

class SetTaskCurrentTaskAction extends ReduxAction<AppState> {
  final String? id;
  SetTaskCurrentTaskAction({
    required this.id,
  });
  @override
  AppState reduce() {
    if (id == null) {
      return state.copyWith(
        taskState: state.taskState.copyWith(
          taskPhraseCurrentSetNull: true,
        ),
      );
    } else {
      TaskModel taskModelTemp;
      TaskModel taskModel;
      if (id!.isNotEmpty) {
        IList<TaskModel> taskModelIList = state.taskState.taskIList!;
        taskModelTemp =
            taskModelIList.firstWhere((element) => element.id == id);
        taskModel = taskModelTemp.copyWith();
      } else {
        FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
        CollectionReference docRef =
            firebaseFirestore.collection(TaskModel.collection);
        String idNew = docRef.doc().id;
        taskModel = TaskModel(
          id: idNew,
          title: '',
        );
      }
      return state.copyWith(
        taskState: state.taskState.copyWith(
          taskCurrent: taskModel,
        ),
      );
    }
    // print('SetTaskCurrentTaskAction: ${state.taskState.taskCurrent}');
    // print('SetTaskCurrentTaskAction: ${taskModel.id}');
  }
}

// // class SetNulPhraseTaskAction extends ReduxAction<AppState> {
// //   @override
// //   AppState reduce() {
// //     return state.copyWith(
// //       taskState: state.taskState.copyWith(
// //         taskPhraseCurrentSetNull: true,
// //         taskPhraseListSetNull: true,
// //       ),
// //     );
// //   }
// // }

class AddDocTaskAction extends ReduxAction<AppState> {
  final TaskModel taskModel;

  AddDocTaskAction({required this.taskModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference docRef =
        firebaseFirestore.collection(TaskModel.collection);

    await docRef.doc(taskModel.id).set(taskModel.toMap()).then(
          (value) =>
              dispatch(AddTranscriptionsTaskAction(taskModel: taskModel)),
        );
    return null;
  }
}

class AddTranscriptionsTaskAction extends ReduxAction<AppState> {
  final TaskModel taskModel;

  AddTranscriptionsTaskAction({required this.taskModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference docRef =
        firebaseFirestore.collection(TranscriptionModel.collection);
    for (var userId in taskModel.team!.userMap.keys) {
      String idNew = docRef.doc().id;
      TranscriptionModel transcriptionModel = TranscriptionModel(
          id: idNew,
          student: taskModel.team!.userMap[userId]!,
          task: taskModel.copyWith(teamSetNull: true));
      await docRef.doc(transcriptionModel.id).set(transcriptionModel.toMap());
    }
    return null;
  }
}

// class UpdateDocTaskAction extends ReduxAction<AppState> {
//   final TaskModel taskModel;

//   UpdateDocTaskAction({required this.taskModel});

//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     DocumentReference docRef =
//         firebaseFirestore.collection(TaskModel.collection).doc(taskModel.id);

//     dispatch(SetTaskCurrentTaskAction(id: ''));
//     if (taskModel.isDeleted) {
//       await docRef.delete();
//     } else {
//       await docRef.update(taskModel.toMap());
//     }

//     return null;
//   }
// }

class ArchiveDocTaskAction extends ReduxAction<AppState> {
  final String taskId;
  final bool isArchived;

  ArchiveDocTaskAction({
    required this.taskId,
    this.isArchived = true,
  });

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef =
        firebaseFirestore.collection(TaskModel.collection).doc(taskId);

    dispatch(SetTaskCurrentTaskAction(id: null));

    await docRef.update({'isArchived': isArchived});

    return null;
  }
}

class DeleteDocTaskAction extends ReduxAction<AppState> {
  final String taskId;

  DeleteDocTaskAction({required this.taskId});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef =
        firebaseFirestore.collection(TaskModel.collection).doc(taskId);

    dispatch(DeleteTranscriptionsTaskAction(taskId: taskId));
    dispatch(SetTaskCurrentTaskAction(id: null));
    await docRef.delete();

    return null;
  }
}

class DeleteTranscriptionsTaskAction extends ReduxAction<AppState> {
  final String taskId;

  DeleteTranscriptionsTaskAction({required this.taskId});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference docRef =
        firebaseFirestore.collection(TaskModel.collection);

    Future<void> batchDelete() {
      WriteBatch batch = FirebaseFirestore.instance.batch();

      return docRef
          .where('task.id', isEqualTo: taskId)
          .get()
          .then((querySnapshot) {
        for (var document in querySnapshot.docs) {
          batch.delete(document.reference);
        }

        return batch.commit();
      });
    }

    await batchDelete();
    return null;
  }
}

class SetTeamTaskAction extends ReduxAction<AppState> {
  final String teamId;

  SetTeamTaskAction({required this.teamId});
  @override
  AppState reduce() {
    TeamModel teamModel = state.teamState.teamIList!
        .firstWhere((element) => element.id == teamId);
    // print('team selected ${teamModel.id}');
    // print('team taskcurrent 1: ${state.taskState.taskCurrent!.team?.id}');

    TaskModel taskModel =
        state.taskState.taskCurrent!.copyWith(team: teamModel);
    // taskModel.team = teamModel;
    return state.copyWith(
      taskState: state.taskState.copyWith(
        taskCurrent: taskModel,
      ),
    );
  }

  @override
  void after() {
    // TODO: implement after
    super.after();
    // print('team taskcurrent 2: ${state.taskState.taskCurrent!.team}');
  }
}

class SetPhraseTaskAction extends ReduxAction<AppState> {
  final String phraseId;

  SetPhraseTaskAction({required this.phraseId});
  @override
  AppState reduce() {
    PhraseModel phraseModel = state.phraseState.phraseIList!
        .firstWhere((element) => element.id == phraseId);
    TaskModel taskModel = state.taskState.taskCurrent!.copyWith();
    taskModel = taskModel.copyWith(phrase: phraseModel);

    return state.copyWith(
      taskState: state.taskState.copyWith(
        taskCurrent: taskModel,
      ),
    );
  }
}

class StreamDocsTranscriptionsTaskAction extends ReduxAction<AppState> {
  final String taskId;

  StreamDocsTranscriptionsTaskAction({required this.taskId});
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(TranscriptionModel.collection)
        .where('task.id', isEqualTo: taskId)
        .where('isArchived', isEqualTo: false)
        .where('isDeleted', isEqualTo: false);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<TranscriptionModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map(
                (docSnapshot) => TranscriptionModel.fromMap(docSnapshot.data()))
            .toList());
    streamList.listen((List<TranscriptionModel> transcriptionModelModelList) {
      dispatch(SetTranscriptionListTranscriptionAction(
          transcriptionIList: IList(transcriptionModelModelList)));
    });

    return null;
  }
}

// // class GetDocsPhraseObservedAndSetNullTaskAction extends ReduxAction<AppState> {
// //   final String taskId;

// //   GetDocsPhraseObservedAndSetNullTaskAction({required this.taskId});
// //   @override
// //   Future<AppState?> reduce() async {
// //     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
// //     Query<Map<String, dynamic>> collRef;
// //     collRef = firebaseFirestore
// //         .collection(PhraseModel.collection)
// //         .where('task', isEqualTo: taskId);

// //     var futureQuerySnapshot = await collRef.get();
// //     var phraseIdList =
// //         futureQuerySnapshot.docs.map((docSnapshot) => docSnapshot.id).toList();
// //     for (var phraseId in phraseIdList) {
// //       dispatch(SetNullTaskFieldPhraseTaskAction(phraseId: phraseId));
// //     }
// //     return null;
// //   }
// // }

// // class SetNullTaskFieldPhraseTaskAction extends ReduxAction<AppState> {
// //   final String phraseId;

// //   SetNullTaskFieldPhraseTaskAction({required this.phraseId});

// //   @override
// //   Future<AppState?> reduce() async {
// //     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
// //     DocumentReference docRef =
// //         firebaseFirestore.collection(PhraseModel.collection).doc(phraseId);
// //     await docRef.update({'task': null});

// //     return null;
// //   }
// // }

// // class StreamDocsPhraseTaskAction extends ReduxAction<AppState> {
// //   @override
// //   Future<AppState?> reduce() async {
// //     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
// //     Query<Map<String, dynamic>> collRef;
// //     collRef = firebaseFirestore
// //         .collection(PhraseModel.collection)
// //         .where('task', isEqualTo: state.taskState.taskCurrent!.id)
// //         .where('isDeleted', isEqualTo: false)
// //         .where('isArchived', isEqualTo: false);

// //     Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
// //         collRef.snapshots();

// //     Stream<List<PhraseModel>> streamList = streamQuerySnapshot.map(
// //         (querySnapshot) => querySnapshot.docs
// //             .map((docSnapshot) =>
// //                 PhraseModel.fromMap(docSnapshot.id, docSnapshot.data()))
// //             .toList());
// //     streamList.listen((List<PhraseModel> phraseModelList) {
// //       dispatch(SetTaskPhraseListTaskAction(taskPhraseList: phraseModelList));
// //     });

// //     return null;
// //   }
// // }

// // class SetTaskPhraseListTaskAction extends ReduxAction<AppState> {
// //   final List<PhraseModel> taskPhraseList;

// //   SetTaskPhraseListTaskAction({required this.taskPhraseList});
// //   @override
// //   AppState reduce() {
// //     taskPhraseList.sort((a, b) => a.phrase.compareTo(b.phrase));
// //     return state.copyWith(
// //       taskState: state.taskState.copyWith(
// //         taskPhraseList: taskPhraseList,
// //       ),
// //     );
// //   }

// //   void after() {
// //     if (state.taskState.taskPhraseCurrent != null) {
// //       dispatch(SetTaskPhraseCurrentTaskAction(
// //           id: state.taskState.taskPhraseCurrent!.id));
// //     }
// //   }
// // }

// // class SetTaskPhraseCurrentTaskAction extends ReduxAction<AppState> {
// //   final String id;
// //   SetTaskPhraseCurrentTaskAction({required this.id});
// //   @override
// //   AppState reduce() {
// //     PhraseModel phraseModel;
// //     phraseModel = state.taskState.taskPhraseList!
// //         .firstWhere((element) => element.id == id);

// //     return state.copyWith(
// //       taskState: state.taskState.copyWith(
// //         taskPhraseCurrent: phraseModel,
// //       ),
// //     );
// //   }
// // }
