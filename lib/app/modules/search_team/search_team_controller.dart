import 'package:get/get.dart';
import 'package:transcribe/app/data/model/team_model.dart';
import 'package:transcribe/app/data/repository/team_repository.dart';
import 'package:transcribe/app/modules/task/task_controller.dart';

class SearchTeamBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeamRepository>(() => TeamRepository());
    Get.lazyPut<SearchTeamController>(() => SearchTeamController());
  }
}

class SearchTeamController extends GetxController {
  final TeamRepository _repository = Get.find<TeamRepository>();

  RxList<TeamModel> list = <TeamModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  void _load() async {
    List<TeamModel> _list = await _repository.getAll();
    try {
      // _list.sort((a, b) => a.displayName!.compareTo(b.displayName!));
    } catch (e) {}
    list(_list);
  }

  setTeam(TeamModel team) {
    TaskController taskController = Get.find<TaskController>();
    taskController.setTeam(team);
    Get.back();
  }
}
