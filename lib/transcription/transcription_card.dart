import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transcribe/task/controller/task_model.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:transcribe/user/controller/user_model.dart';

class TranscriptionCard extends StatelessWidget {
  final TaskModel task;
  final List<Widget>? widgetList;
  const TranscriptionCard({
    Key? key,
    required this.task,
    this.widgetList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            child: Text(
              task.title,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            height: 1,
            color: Colors.green,
          ),
          Wrap(
            children: widgetList ?? [],
          )
        ],
      ),
    );
  }
}
