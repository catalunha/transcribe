import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transcribe/task/controller/task_model.dart';
import 'package:transcribe/theme/app_icon.dart';

import 'transcription_card.dart';

class TranscriptionList extends StatelessWidget {
  final IList<TaskModel> taskIList;
  final String userId;

  const TranscriptionList({
    Key? key,
    required this.taskIList,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select one tasks for solve'),
        actions: [
          IconButton(
            tooltip: 'Archived sentences',
            icon: Icon(AppIconData.box),
            onPressed: () {
              // Navigator.pushNamed(
              //   context,
              //   '/transcription_edit',
              //   arguments: task.id,
              // );
            },
          )
        ],
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

    for (var task in taskIList) {
      list.add(
        Container(
          key: ValueKey(task),
          child: Card(
            child: ListTile(
              leading: Icon(AppIconData.edit),
              title: Text(
                task.name,
                // textAlign: TextAlign.start,
                style: TextStyle(fontSize: 30),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/transcription_edit',
                  arguments: task.id,
                );
              },
              trailing: listEquals(task.phrase!.phraseList,
                      task.transcriptionMap?[userId]?.phraseOrdered)
                  ? IconButton(
                      tooltip: 'Archive this sentence',
                      icon: Icon(AppIconData.inbox),
                      onPressed: () {
                        // Navigator.pushNamed(
                        //   context,
                        //   '/transcription_edit',
                        //   arguments: task.id,
                        // );
                      },
                    )
                  : Container(
                      width: 1,
                    ),
            ),
          ),

          // TranscriptionCard(
          //   task: task,
          //   widgetList: [
          //     IconButton(
          //       tooltip: 'Edit this task.',
          //       icon: Icon(AppIconData.edit),
          //       onPressed: () {
          //         Navigator.pushNamed(
          //           context,
          //           '/transcription_edit',
          //           arguments: task.id,
          //         );
          //       },
          //     ),
          //     listEquals(task.phrase!.phraseList,
          //             task.transcriptionMap?[userId]?.phraseOrdered)
          //         ? IconButton(
          //             tooltip: 'Archive this sentence',
          //             icon: Icon(AppIconData.inbox),
          //             onPressed: () {
          //               // Navigator.pushNamed(
          //               //   context,
          //               //   '/transcription_edit',
          //               //   arguments: task.id,
          //               // );
          //             },
          //           )
          //         : Container(
          //             width: 1,
          //           ),
          //   ],
          // ),
        ),
      );
      // list.add(
      //   Container(
      //     key: ValueKey(task),
      //     child: TranscriptionCard(
      //       task: task,
      //       widgetList: [
      //         IconButton(
      //           tooltip: 'Edit this task.',
      //           icon: Icon(AppIconData.edit),
      //           onPressed: () {
      //             Navigator.pushNamed(
      //               context,
      //               '/transcription_edit',
      //               arguments: task.id,
      //             );
      //           },
      //         ),
      //         listEquals(task.phrase!.phraseList,
      //                 task.transcriptionMap?[userId]?.phraseOrdered)
      //             ? IconButton(
      //                 tooltip: 'Archive this sentence',
      //                 icon: Icon(AppIconData.inbox),
      //                 onPressed: () {
      //                   // Navigator.pushNamed(
      //                   //   context,
      //                   //   '/transcription_edit',
      //                   //   arguments: task.id,
      //                   // );
      //                 },
      //               )
      //             : Container(
      //                 width: 1,
      //               ),
      //       ],
      //     ),
      //   ),
      // );
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
