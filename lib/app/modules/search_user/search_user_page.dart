import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/modules/search_user/search_user_controller.dart';
import 'package:transcribe/app/modules/team/team_controller.dart';
import 'package:transcribe/app/theme/app_icon.dart';

class SearchUserPage extends GetView<SearchUserController> {
  TeamController teamController = Get.find<TeamController>();

  SearchUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            'You have ${controller.list.length} users in app and ${teamController.model.students.length} students in this team.')),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(child: buildItens(context)),
          ),
        ],
      ),
    );
  }

  Widget buildItens(context) {
    return Obx(() {
      if (controller.list.isNotEmpty) {
        List<Widget> listWidget = [];
        for (var model in controller.list) {
          listWidget.add(ListTile(
            tileColor:
                teamController.model.students.keys.toList().contains(model.id)
                    ? Colors.green
                    : null,
            title: Text('${model.displayName}'),
            subtitle: Text(model.email),
            leading: model.photoURL == null
                ? const SizedBox(
                    height: 58,
                    width: 58,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      model.photoURL!,
                      height: 58,
                      width: 58,
                    ),
                  ),
            onTap: () {
              controller.onAddOrRemoveStudent(
                  !teamController.model.students.keys
                      .toList()
                      .contains(model.id),
                  model.id);
            },
            trailing: IconButton(
              icon: const Icon(AppIconData.copy),
              onPressed: () {
                Future<void> _copyToClipboard() async {
                  await Clipboard.setData(ClipboardData(text: model.email));
                }

                _copyToClipboard();
                Get.snackbar("Hi", "This email ${model.email} is copied");
              },
            ),
          ));
        }
        return Column(
          children: listWidget,
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
