import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:transcribe/phrase/controller/phrase_model.dart';
import 'package:transcribe/team/controller/team_model.dart';
import 'package:transcribe/user/controller/user_model.dart';

import '../../app_state.dart';
import 'task_model.dart';

class StreamDocsTaskAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(TaskModel.collection)
        .where('team.teacher.id', isEqualTo: state.userState.userCurrent!.id)
        .where('isArchivedByTeacher', isEqualTo: false)
        .where('isDeleted', isEqualTo: false);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<IList<TaskModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) => TaskModel.fromMap(docSnapshot.data()))
            .toIList());
    streamList.listen((IList<TaskModel> taskModelList) {
      dispatch(SetTaskListTaskAction(taskList: IList(taskModelList)));
    });

    return null;
  }
}

class SetTaskListTaskAction extends ReduxAction<AppState> {
  final IList<TaskModel> taskList;

  SetTaskListTaskAction({required this.taskList});
  @override
  AppState reduce() {
    taskList.sort((a, b) => a.name.compareTo(b.name));
    for (var task in taskList) {
      // print('SetTaskListTaskAction: $task');
    }
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

class SetTaskCurrentTaskAction extends ReduxAction<AppState> {
  final String id;
  SetTaskCurrentTaskAction({
    required this.id,
  });
  @override
  AppState reduce() {
    TaskModel taskModelTemp;
    TaskModel taskModel;
    if (id.isNotEmpty) {
      IList<TaskModel> taskModelIList = state.taskState.taskIList!;
      taskModelTemp = taskModelIList.firstWhere((element) => element.id == id);
      taskModel = taskModelTemp.copyWith();
    } else {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      CollectionReference docRef =
          firebaseFirestore.collection(TaskModel.collection);
      String idNew = docRef.doc().id;
      taskModel = TaskModel(
        id: idNew,
        name: '',
      );
    }
    // print('SetTaskCurrentTaskAction: ${state.taskState.taskCurrent}');
    // print('SetTaskCurrentTaskAction: ${taskModel.id}');

    return state.copyWith(
      taskState: state.taskState.copyWith(
        taskCurrent: taskModel,
      ),
    );
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

    await docRef.doc(taskModel.id).set(taskModel.toMap());
    return null;
  }
}

class UpdateDocTaskAction extends ReduxAction<AppState> {
  final TaskModel taskModel;

  UpdateDocTaskAction({required this.taskModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef =
        firebaseFirestore.collection(TaskModel.collection).doc(taskModel.id);

    dispatch(SetTaskCurrentTaskAction(id: ''));
    if (taskModel.isDeleted) {
      await docRef.delete();
    } else {
      await docRef.update(taskModel.toMap());
    }

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