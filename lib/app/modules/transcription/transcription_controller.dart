import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/data/model/transcription_model.dart';
import 'package:transcribe/app/data/repository/transcription_repository.dart';

class TranscriptionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TranscriptionRepository>(() => TranscriptionRepository());
    Get.lazyPut<TranscriptionController>(() => TranscriptionController());
  }
}

class TranscriptionController extends GetxController {
  final TranscriptionRepository _repository =
      Get.find<TranscriptionRepository>();
  RxList<TranscriptionModel> list = <TranscriptionModel>[].obs;
  RxList<TranscriptionModel> listArchived = <TranscriptionModel>[].obs;
  late Rx<TranscriptionModel> _model;
  TranscriptionModel get model => _model.value;

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

    Get.toNamed('/transcriptionArchived');
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

  onSave() {
    bool orderedSolved = false;
    orderedSolved = listEquals(
        _model.value.task.phrase!.phraseList, _model.value.phraseOrdered);
    bool writtenSolved = false;
    writtenSolved = _model.value.task.phrase!.phraseList.join(' ') ==
        _model.value.phraseWritten;

    onChangeModel(isSolved: orderedSolved || writtenSolved);
    _repository.set(_model.value);
    Get.back();
  }

  String? formValidateRequiredText(String? value) =>
      value?.isEmpty ?? true ? 'This field cannot be empty.' : null;

  void onChangeModel({
    String? phraseWritten,
    List<String>? phraseOrdered,
    bool? isSolved,
  }) {
    _model.update((value) {
      if (phraseWritten != null) {
        value!.phraseWritten = phraseWritten;
        bool writtenSolved = false;
        writtenSolved =
            _model.value.task.phrase!.phraseList.join(' ') == phraseWritten;

        onChangeModel(isSolved: writtenSolved);
      }
    });
    _model.update((value) {
      if (phraseOrdered != null) {
        value!.phraseOrdered = phraseOrdered;
        bool orderedSolved = false;
        orderedSolved =
            listEquals(_model.value.task.phrase!.phraseList, phraseOrdered);
        onChangeModel(isSolved: orderedSolved);
      }
    });
    _model.update((value) {
      if (isSolved != null) {
        value!.isSolved = isSolved;
      }
    });
  }

  validateExtraFields() {
    isExtraFieldsValid = true;
  }

  void edit(String id) {
    addOrEdit = false;
    TranscriptionModel _teamModel =
        list.firstWhere((element) => element.id == id);
    if (_teamModel.phraseOrdered!.isEmpty) {
      List<String> temp = _teamModel.task.phrase!.phraseList.toList();
      temp.sort();
      _model = _teamModel.copyWith(phraseOrdered: temp).obs;
    } else {
      _model = _teamModel.copyWith().obs;
    }
    Get.toNamed('/transcriptionEdit');
  }

  delete(String id) {
    _repository.delete(id);
  }

  archive(String id, bool status) {
    _repository.update(id, {'isArchived': status});
  }
}
