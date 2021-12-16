import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/data/model/phrase_model.dart';
import 'package:transcribe/app/data/model/user_model.dart';
import 'package:transcribe/app/data/repository/phrase_repository.dart';
import 'package:transcribe/app/modules/user/user_controller.dart';

class PhraseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhraseRepository>(() => PhraseRepository());
    Get.lazyPut<PhraseController>(() => PhraseController());
  }
}

class PhraseController extends GetxController {
  final PhraseRepository _repository = Get.find<PhraseRepository>();

  RxList<PhraseModel> list = <PhraseModel>[].obs;

  late Rx<PhraseModel> _model;
  get model => _model.value;

  bool addOrEdit = false;
  final formKey = GlobalKey<FormState>();
  bool isExtraFieldsValid = false;

  @override
  void onInit() {
    super.onInit();
    list.bindStream(_repository.streamAll());
  }

  void add() {
    addOrEdit = true;

    UserController userController = Get.find<UserController>();

    _model = PhraseModel(
      id: _repository.newId(),
      teacher: UserRef.fromMap({
        'id': userController.userModel.id,
        'email': userController.userModel.email,
        'photoURL': userController.userModel.photoURL,
        'displayName': userController.userModel.displayName
      }),
      group: '',
      phraseList: [],
      phraseAudio: '',
    ).obs;
    Get.toNamed('/phraseAddEdit');
  }

  void addCopyWith(String id) {
    addOrEdit = true;
    UserController userController = Get.find<UserController>();

    PhraseModel _modelTemp = list.firstWhere((element) => element.id == id);

    _model = PhraseModel(
      id: _repository.newId(),
      teacher: UserRef.fromMap({
        'id': userController.userModel.id,
        'email': userController.userModel.email,
        'photoURL': userController.userModel.photoURL,
        'displayName': userController.userModel.displayName
      }),
      group: _modelTemp.group,
      phraseList: [],
      phraseAudio: '',
    ).obs;

    Get.toNamed('/phraseAddEdit');
  }

  void edit(String id) {
    addOrEdit = false;

    PhraseModel _modelTemp = list.firstWhere((element) => element.id == id);
    _model = _modelTemp.copyWith().obs;
    Get.toNamed('/phraseAddEdit');
  }

  delete() {
    _repository.delete(_model.value.id);
    Get.back();
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
    String? phrase,
    String? group,
    String? phraseAudio,
  }) {
    _model.update((value) {
      if (phrase != null) {
        value!.phraseList = phrase.split('\n');
      }
      if (group != null) {
        value!.group = group;
      }
      if (phraseAudio != null) {
        value!.phraseAudio = phraseAudio;
      }
    });
  }

  validateExtraFields() {
    isExtraFieldsValid = true;
    if (_model.value.phraseAudio.isEmpty) {
      isExtraFieldsValid = false;
    }
  }
}
