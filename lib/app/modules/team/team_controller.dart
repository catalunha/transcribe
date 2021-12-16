import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/data/model/team_model.dart';
import 'package:transcribe/app/data/model/user_model.dart';
import 'package:transcribe/app/data/repository/team_repository.dart';
import 'package:transcribe/app/modules/user/user_controller.dart';

class TeamBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeamRepository>(() => TeamRepository());
    Get.lazyPut<TeamController>(() => TeamController());
  }
}

class TeamController extends GetxController {
  final TeamRepository _repository = Get.find<TeamRepository>();
  RxList<TeamModel> list = <TeamModel>[].obs;
  late Rx<TeamModel> _model;
  get model => _model.value;

  bool addOrEdit = false;
  final formKey = GlobalKey<FormState>();
  bool isExtraFieldsValid = false;

  @override
  void onInit() {
    super.onInit();
    list.bindStream(_repository.streamAll());
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
    String? name,
  }) {
    _model.update((value) {
      if (name != null) {
        value!.name = name;
      }
    });
  }

  validateExtraFields() {
    isExtraFieldsValid = true;
    if (_model.value.students.isEmpty) {
      isExtraFieldsValid = false;
    }
  }

  void add() {
    addOrEdit = true;
    UserController userController = Get.find<UserController>();

    _model = TeamModel(
      id: _repository.newId(),
      teacher: UserRef.fromMap({
        'id': userController.userModel.id,
        'email': userController.userModel.email,
        'photoURL': userController.userModel.photoURL,
        'displayName': userController.userModel.displayName
      }),
      name: '',
      students: <String, UserRef>{},
    ).obs;
    Get.toNamed('/teamAddEdit');
  }

  void edit(String id) {
    addOrEdit = false;
    TeamModel _teamModel = list.firstWhere((element) => element.id == id);
    _model = _teamModel.copyWith().obs;
    Get.toNamed('/teamAddEdit');
  }

  delete() {
    _repository.delete(_model.value.id);
    Get.back();
  }

  removeStudent(String userId) {
    _model.update((value) {
      value!.students.remove(userId);
    });
  }

  addStudent(UserRef userRef) {
    _model.update((value) {
      value!.students.addAll({userRef.id: userRef});
    });
  }
}
