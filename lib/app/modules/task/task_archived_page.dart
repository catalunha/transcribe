import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/theme/app_icon.dart';
import 'task_card.dart';
import 'task_controller.dart';

class TaskArchivedPage extends GetView<TaskController> {
  const TaskArchivedPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My tasks archived'),
        foregroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: buildItens(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItens(context) {
    return Obx(() {
      if (controller.listArchived.isNotEmpty) {
        List<Widget> list = [];

        for (var model in controller.listArchived) {
          list.add(Container(
            key: ValueKey(model),
            child: TaskCard(
              task: model,
              colorPhrase: model.isWritten ? Colors.blue : Colors.grey,
              widgetList: [
                IconButton(
                  tooltip: 'People in this task.',
                  icon: const Icon(AppIconData.people),
                  onPressed: () {
                    controller.toPeopleOnTask(model.id);
                  },
                ),
                IconButton(
                  tooltip: 'Archive this task.',
                  icon: const Icon(AppIconData.outbox),
                  onPressed: () {
                    controller.onArchive(model.id, false);
                    Get.back();
                  },
                ),
                IconButton(
                  tooltip: 'Delete this task',
                  icon: const Icon(AppIconData.delete),
                  onPressed: () {
                    controller.delete(model.id);
                  },
                ),
              ],
            ),
          ));
        }
        return Column(
          children: list,
        );
      } else {
        return const ListTile(
          leading: Icon(AppIconData.smile),
          title: Text("Ops. You don't have any task archived."),
        );
      }
    });
  }
}
