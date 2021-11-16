import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';

import 'controller/transcription_model.dart';

class TranscriptionListArchived extends StatelessWidget {
  final IList<TranscriptionModel> transcriptionIList;
  final Function(String) onArchive;
  final Function(String) onDelete;

  const TranscriptionListArchived({
    Key? key,
    required this.transcriptionIList,
    required this.onArchive,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your tasks archived'),
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
              leading: IconButton(
                tooltip: 'delete this sentence',
                icon: const Icon(AppIconData.delete),
                onPressed: () {
                  onDelete(transcription.id);
                },
              ),
              title: Text(
                transcription.task.title,
                // textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 30),
              ),
              trailing: IconButton(
                tooltip: 'unarchive this sentence',
                icon: const Icon(AppIconData.outbox),
                onPressed: () {
                  onArchive(transcription.id);
                },
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
