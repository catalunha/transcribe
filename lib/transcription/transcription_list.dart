import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';

import 'controller/transcription_model.dart';

class TranscriptionList extends StatelessWidget {
  final IList<TranscriptionModel> transcriptionIList;
  final Function(String) onArchive;

  const TranscriptionList({
    Key? key,
    required this.transcriptionIList,
    required this.onArchive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select one tasks for solve'),
        actions: [
          IconButton(
            tooltip: 'Archived sentences',
            icon: const Icon(AppIconData.box),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/transcription_archived',
              );
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

    for (var transcription in transcriptionIList) {
      list.add(
        Container(
          key: ValueKey(transcription),
          child: Card(
            child: ListTile(
              tileColor: transcription.isSolved ? Colors.green : null,
              leading: transcription.task.isWritten
                  ? const Icon(AppIconData.digit)
                  : const Icon(AppIconData.order),
              title: Text(
                transcription.task.title,
                // textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 30),
              ),
              // subtitle: Text(transcription.id),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/transcription_edit',
                  arguments: transcription.id,
                );
              },
              trailing: transcription.isSolved
                  ? IconButton(
                      tooltip: 'Archive this transcription',
                      icon: const Icon(AppIconData.inbox),
                      onPressed: () {
                        onArchive(transcription.id);
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
      list.add(const ListTile(
        leading: Icon(AppIconData.smile),
        title: Text("Ops. You don't have any task."),
      ));
    }
    return list;
  }
}
