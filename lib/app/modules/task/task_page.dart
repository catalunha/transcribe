import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/modules/task/task_card.dart';
import 'package:transcribe/app/theme/app_icon.dart';

import 'task_controller.dart';

class TaskPage extends GetView<TaskController> {
  const TaskPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My tasks'),
        actions: [
          IconButton(
            tooltip: 'Archived sentences',
            icon: const Icon(AppIconData.box),
            onPressed: () {
              controller.toArchived();
            },
          )
        ],
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
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create new task.',
        child: const Icon(AppIconData.addInCloud),
        onPressed: () {
          controller.add();
        },
      ),
    );
  }

  Widget buildItens(context) {
    return Obx(() {
      if (controller.list.isNotEmpty) {
        List<Widget> list = [];

        for (var model in controller.list) {
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
                  icon: const Icon(AppIconData.inbox),
                  onPressed: () {
                    controller.onArchive(model.id, true);
                  },
                ),
                IconButton(
                  tooltip: 'Copy this task with...',
                  icon: const Icon(AppIconData.clone),
                  onPressed: () {
                    controller.addCopyWith(model.id);
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
          title: Text("Ops. You don't have any task."),
        );
      }
    });
  }
}
