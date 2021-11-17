import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:transcribe/transcription/controller/transcription_model.dart';

class TaskPeopleList extends StatelessWidget {
  final IList<TranscriptionModel> transcriptionIList;

  const TaskPeopleList({
    Key? key,
    required this.transcriptionIList,
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

    for (TranscriptionModel transcription in transcriptionIList) {
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
                          await Clipboard.setData(
                              ClipboardData(text: transcription.student.email));
                        }

                        _copyToClipboard();
                        final snackBar = SnackBar(
                            backgroundColor: Colors.green.shade900,
                            content: Text(
                              'This email ${transcription.student.email} is copied',
                              style: const TextStyle(color: Colors.white),
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
    if (list.isEmpty) {
      list.add(const ListTile(
        leading: Icon(AppIconData.smile),
        title: Text("Ops. You don't have any person in this task."),
      ));
    }
    return list;
  }
}
