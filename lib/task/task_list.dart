import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transcribe/theme/app_icon.dart';

import 'controller/task_model.dart';
import 'task_card.dart';

class TaskList extends StatelessWidget {
  final IList<TaskModel> taskIList;
  final Function(String) onArchive;
  final Function(String) onDelete;
  const TaskList({
    Key? key,
    required this.taskIList,
    required this.onArchive,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My tasks'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildItens(context),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create new task.',
        child: Icon(AppIconData.addInCloud),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/task_addOrEdit',
            arguments: '',
          );
        },
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];

    for (var task in taskIList) {
      list.add(Container(
        key: ValueKey(task),
        child: TaskCard(
          task: task,
          widgetList: [
            IconButton(
              tooltip: 'People in this task.',
              icon: Icon(AppIconData.people),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/task_people_list',
                  arguments: task.id,
                );
              },
            ),
            IconButton(
              tooltip: 'Archive this task.',
              icon: Icon(AppIconData.inbox),
              onPressed: () {
                onArchive(task.id);
              },
            ),
            IconButton(
              tooltip: 'Delete this task.',
              icon: Icon(AppIconData.delete),
              onPressed: () {
                onDelete(task.id);
              },
            ),
          ],
        ),
      ));
    }
    if (list.isEmpty) {
      list.add(ListTile(
        leading: Icon(AppIconData.smile),
        title: Text("Ops. You don't have any task."),
      ));
    }
    return list;
  }
}
