import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/data/model/phrase_model.dart';
import 'package:transcribe/app/data/model/task_model.dart';
import 'package:transcribe/app/data/model/team_model.dart';
import 'package:transcribe/app/data/model/transcription_model.dart';
import 'package:transcribe/app/data/repository/task_repository.dart';
import 'package:transcribe/app/data/repository/transcription_repository.dart';

class TaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaskRepository>(() => TaskRepository());
    Get.lazyPut<TranscriptionRepository>(() => TranscriptionRepository());
    Get.lazyPut<TaskController>(() => TaskController());
  }
}

class TaskController extends GetxController {
  final TaskRepository _repository = Get.find<TaskRepository>();

  RxList<TaskModel> list = <TaskModel>[].obs;
  RxList<TaskModel> listArchived = <TaskModel>[].obs;
  RxList<TranscriptionModel> transcriptionListOfPeopleOnTask =
      <TranscriptionModel>[].obs;

  late Rx<TaskModel> _model;
  get model => _model.value;

  bool addOrEdit = false;
  final formKey = GlobalKey<FormState>();
  bool isExtraFieldsValid = false;

  @override
  void onInit() {
    super.onInit();
    list.bindStream(_repository.streamAll());
  }

  toArchived() {
    listArchived.bindStream(_repository.streamAllArchived());

    Get.toNamed('/taskArchived');
  }

  toPeopleOnTask(String taskId) {
    final TranscriptionRepository _repositoryTranscription =
        Get.find<TranscriptionRepository>();

    transcriptionListOfPeopleOnTask.bindStream(_repositoryTranscription
        .streamAllTranscriptionListOfPeopleOnTask(taskId));

    Get.toNamed('/taskPeopleOnTask');
  }

  void add() {
    addOrEdit = true;

    _model = TaskModel(
      id: _repository.newId(),
    ).obs;
    Get.toNamed('/taskAddEdit');
  }

  void addCopyWith(String id) {
    addOrEdit = true;

    TaskModel _modelTemp = list.firstWhere((element) => element.id == id);

    _model = TaskModel(
      id: _repository.newId(),
      title: _modelTemp.title,
      isWritten: _modelTemp.isWritten,
      team: _modelTemp.team,
      phrase: _modelTemp.phrase,
    ).obs;

    Get.toNamed('/taskAddEdit');
  }

  delete(String id) {
    _repository.delete(id);
  }

  onArchive(String id, bool status) {
    _repository.update(id, {'isArchived': status});
  }

  setTeam(TeamModel team) {
    _model.update((value) {
      value!.team = team;
    });
  }

  setPhrase(PhraseModel phrase) {
    _model.update((value) {
      value!.phrase = phrase;
    });
  }

  void formSubmit() {
    validateExtraFields();
    if (!isExtraFieldsValid) {
      Get.snackbar('Hi', 'Please, see fields requerided.');
    } else {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        _repository.set(_model.value);
        Get.back();
      }
    }
  }

  String? formValidateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'This field cannot be empty.' : null;

  void onChangeModel({
    String? title,
    bool? isWritten,
  }) {
    _model.update((value) {
      if (title != null) {
        value!.title = title;
      }
      if (isWritten != null) {
        value!.isWritten = isWritten;
      }
    });
  }

  validateExtraFields() {
    isExtraFieldsValid = true;
  }
}
