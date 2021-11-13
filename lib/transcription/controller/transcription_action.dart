import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:transcribe/phrase/controller/phrase_model.dart';
import 'package:transcribe/task/controller/task_action.dart';
import 'package:transcribe/task/controller/task_model.dart';
import 'package:transcribe/team/controller/team_model.dart';
import 'package:transcribe/user/controller/user_model.dart';

import '../../app_state.dart';

class StreamDocsTranscriptionAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(TaskModel.collection)
        .where('team.userList', arrayContains: state.userState.userCurrent!.id)
        .where('isArchivedByStudent', isEqualTo: false)
        .where('isDeleted', isEqualTo: false);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<IList<TaskModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) => TaskModel.fromMap(docSnapshot.data()))
            .toIList());
    streamList.listen((IList<TaskModel> taskModelList) {
      for (var task in taskModelList) {
        print('StreamDocsTranscriptionAction: $task');
      }
      dispatch(SetTaskListTaskAction(taskList: taskModelList));
    });

    return null;
  }
}

class ResetPhraseCurrentTranscriptionAction extends ReduxAction<AppState> {
  ResetPhraseCurrentTranscriptionAction();
  @override
  AppState reduce() {
    final String phraseCurrentId = state.taskState.taskCurrent!.id;

    TaskModel taskModel;
    taskModel = state.taskState.taskIList!
        .firstWhere((element) => element.id == phraseCurrentId);
    print(
        'ResetPhraseCurrentTranscriptionAction 1: ${taskModel.transcriptionMap ?? "null"}');

    return state.copyWith(
      taskState: state.taskState.copyWith(
        taskCurrent: taskModel.copyWith(),
      ),
    );
  }
}

class SetTaskCurrentTranscriptionAction extends ReduxAction<AppState> {
  final String id;
  SetTaskCurrentTranscriptionAction({
    required this.id,
  });
  @override
  before() {
    for (var task in state.taskState.taskIList!) {
      print('SetTaskCurrentTranscriptionAction.before list : $task');
    }
    print(
        'SetTaskCurrentTranscriptionAction.before current: ${state.taskState.taskCurrent!}');
  }

  @override
  AppState reduce() {
    IList<TaskModel> taskModelList = state.taskState.taskIList!;
    // TaskModel taskModelTemp;
    // taskModelTemp = taskModelList.firstWhere((element) => element.id == id);
    late TaskModel taskModel;
    for (var task in taskModelList) {
      if (task.id == id) {
        taskModel = task.copyWith();
      }
    }
    if (taskModel.transcriptionMap == null) {
      taskModel =
          taskModel.copyWith(transcriptionMap: <String, Transcription>{});
    }
    String userId = state.userState.userCurrent!.id;
    if (!taskModel.transcriptionMap!.containsKey(userId)) {
      print('atualiznado o que ja conte,');
      List<String> temp = taskModel.phrase!.phraseList;
      temp.sort();
      Transcription transcription = Transcription(
        phraseOrdered: temp,
      );
      Map<String, Transcription> transcriptionMapTemp =
          taskModel.transcriptionMap!; //<userId,Transcription
      transcriptionMapTemp.addAll({userId: transcription});
      taskModel = taskModel.copyWith(transcriptionMap: transcriptionMapTemp);
    }

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
    for (var task in state.taskState.taskIList!) {
      print('SetTaskCurrentTranscriptionAction.after list : $task');
    }
    print(
        'SetTaskCurrentTranscriptionAction.after current: ${state.taskState.taskCurrent}');
  }
}

class SetNewOrderTranscriptionAction extends ReduxAction<AppState> {
  final List<String> newOrder;
  SetNewOrderTranscriptionAction({
    required this.newOrder,
  });
  @override
  AppState reduce() {
    String userId = state.userState.userCurrent!.id;
    TaskModel taskModel = state.taskState.taskCurrent!.copyWith();
    taskModel.transcriptionMap![userId]!.phraseOrdered = newOrder;

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
    for (var task in state.taskState.taskIList!) {
      print('SetNewOrderTranscriptionAction.after list : $task');
    }
    print(
        'SetNewOrderTranscriptionAction.after current: ${state.taskState.taskCurrent!}');
  }
}

class UpdateDocTranscriptionAction extends ReduxAction<AppState> {
  UpdateDocTranscriptionAction();

  @override
  Future<AppState?> reduce() async {
    TaskModel taskModel = state.taskState.taskCurrent!.copyWith();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef =
        firebaseFirestore.collection(TaskModel.collection).doc(taskModel.id);
    String userId = state.userState.userCurrent!.id;
    Transcription transcription = taskModel.transcriptionMap![userId]!;
//TODO
// remover da lista
    // dispatch(SetTaskCurrentTaskAction(id: ''));

    await docRef.update({
      'transcriptionMap': {userId: transcription.toMap()}
    });

    return null;
  }
}
