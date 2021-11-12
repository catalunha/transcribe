import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transcribe/task/controller/task_model.dart';
import 'package:transcribe/theme/app_icon.dart';

import 'transcription_card.dart';

class TranscriptionList extends StatelessWidget {
  final List<TaskModel> taskList;

  const TranscriptionList({
    Key? key,
    required this.taskList,
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
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];

    for (var task in taskList) {
      list.add(Container(
        key: ValueKey(task),
        child: TranscriptionCard(
          task: task,
          widgetList: [
            IconButton(
              tooltip: 'Edit this task.',
              icon: Icon(AppIconData.edit),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/transcription_edit',
                  arguments: task.id,
                );
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
