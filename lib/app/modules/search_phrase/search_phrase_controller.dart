import 'package:get/get.dart';
import 'package:transcribe/app/data/model/phrase_model.dart';
import 'package:transcribe/app/data/repository/phrase_repository.dart';
import 'package:transcribe/app/modules/task/task_controller.dart';

class SearchPhraseBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhraseRepository>(() => PhraseRepository());
    Get.lazyPut<SearchPhraseController>(() => SearchPhraseController());
  }
}

class SearchPhraseController extends GetxController {
  final PhraseRepository _repository = Get.find<PhraseRepository>();

  RxList<PhraseModel> list = <PhraseModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  void _load() async {
    List<PhraseModel> _list = await _repository.getAll();
    list(_list);
  }

  setPhrase(PhraseModel phrase) {
    TaskController taskController = Get.find<TaskController>();
    taskController.setPhrase(phrase);
    Get.back();
  }
}
