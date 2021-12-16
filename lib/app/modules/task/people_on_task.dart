import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/data/model/transcription_model.dart';
import 'package:transcribe/app/theme/app_icon.dart';

import 'task_controller.dart';

class PeopleOnTask extends GetView<TaskController> {
  const PeopleOnTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People in this task'),
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
      if (controller.transcriptionListOfPeopleOnTask.isNotEmpty) {
        List<Widget> list = [];

        for (TranscriptionModel transcription
            in controller.transcriptionListOfPeopleOnTask) {
          list.add(
            Container(
                key: ValueKey(transcription),
                child: Card(
                  elevation: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: transcription.student.photoURL == null
                            ? const Icon(AppIconData.undefined)
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  transcription.student.photoURL!,
                                  height: 58,
                                  width: 58,
                                ),
                              ),
                        title: Text('${transcription.student.displayName}'),
                        subtitle: Text(transcription.student.email),
                        trailing: IconButton(
                          icon: const Icon(AppIconData.email),
                          onPressed: () {
                            Future<void> _copyToClipboard() async {
                              await Clipboard.setData(ClipboardData(
                                  text: transcription.student.email));
                            }

                            _copyToClipboard();
                            Get.snackbar("Hi",
                                "This email ${transcription.student.email} is copied");
                          },
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.blue,
                      ),
                      transcription.task.isWritten
                          ? Container(
                              width: double.infinity,
                              color: transcription.phraseWritten ==
                                      transcription.task.phrase!.phraseList
                                          .join(' ')
                                  ? Colors.green
                                  : null,
                              child: Text(
                                transcription.phraseWritten!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              color: listEquals(transcription.phraseOrdered!,
                                      transcription.task.phrase!.phraseList)
                                  ? Colors.green
                                  : null,
                              child: Text(
                                transcription.phraseOrdered!.join(' '),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                    ],
                  ),
                )),
          );
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
