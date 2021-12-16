import 'package:get/get.dart';
import 'package:transcribe/app/data/model/user_model.dart';
import 'package:transcribe/app/data/repository/user_repository.dart';
import 'package:transcribe/app/modules/team/team_controller.dart';

class SearchUserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserRepository>(() => UserRepository());
    Get.lazyPut<SearchUserController>(() => SearchUserController());
  }
}

class SearchUserController extends GetxController {
  final UserRepository _userRepository = Get.find<UserRepository>();
  TeamController teamController = Get.find<TeamController>();

  RxList<UserRef> list = <UserRef>[].obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  void _load() async {
    List<UserModel> _list = await _userRepository.getAll();
    try {
      _list.sort((a, b) => a.displayName!.compareTo(b.displayName!));
    } catch (e) {}
    list(_list
        .map(
          (userModel) => UserRef(
              id: userModel.id,
              email: userModel.email,
              photoURL: userModel.photoURL,
              displayName: userModel.displayName),
        )
        .toList());
  }

  onAddOrRemoveStudent(bool add, String userId) {
    UserRef userRef = list.firstWhere((element) => element.id == userId);
    if (add) {
      teamController.addStudent(userRef);
    } else {
      teamController.removeStudent(userRef.id);
    }
  }
}
