import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/modules/player_audio/player_audio_widget.dart';
import 'package:transcribe/app/theme/app_icon.dart';

import 'transcription_controller.dart';

class TranscriptionEdit extends GetView<TranscriptionController> {
  const TranscriptionEdit({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transcribing'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text('Click to listen the audio:'),
            ),
            audio(),
            if (controller.model.task.isWritten) ...typing() else ...ordering(),
            Obx(() {
              return
                  // listEquals(controller.model.task.phrase!.phraseList,
                  //             controller.model.phraseOrdered) ||
                  //         (controller.model.task.phrase!.phraseList.join(' ') ==
                  //             controller.model.phraseWritten)
                  controller.model.isSolved
                      ? const Center(
                          child: Text(
                            'Good job. Save now please !',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30,
                            ),
                          ),
                        )
                      : Container();
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save this transcription in cloud',
        child: const Icon(AppIconData.saveInCloud),
        onPressed: () {
          controller.onSave();
        },
      ),
    );
  }

  List<Widget> typing() {
    final myController = TextEditingController();
    myController.text = 'ss';
    return [
      const Align(
        alignment: Alignment.topLeft,
        child: Text('And type the sentence:'),
      ),
      TextField(
        controller: myController,
        style: const TextStyle(fontSize: 32),
        onChanged: (value) {
          controller.onChangeModel(phraseWritten: value);
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'here',
        ),
      ),
    ];
  }

  List<Widget> ordering() {
    return [
      const Align(
        alignment: Alignment.topLeft,
        child: Text('And move the boxes to order the sentence:'),
      ),
      Container(
        constraints: const BoxConstraints(
          maxHeight: 80,
        ),
        child: Obx(() => ReorderableListView(
              scrollDirection: Axis.horizontal,
              onReorder: _onReorder,
              children: buildPhrase(),
            )),
      ),
    ];
  }

  PlayerAudioWidget audio() {
    return PlayerAudioWidget(url: controller.model.task.phrase!.phraseAudio);
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    List<String> listTemp = [];
    listTemp.addAll(controller.model.phraseOrdered!);
    String resourceId = listTemp[oldIndex];
    listTemp.removeAt(oldIndex);
    listTemp.insert(newIndex, resourceId);
    controller.onChangeModel(phraseOrdered: listTemp);
  }

  List<Widget> buildPhrase() {
    List<Widget> temp = [];

    for (var item in controller.model.phraseOrdered!) {
      temp.add(word(item));
    }
    return temp;
  }

  Widget word(String name) {
    return Container(
      key: ValueKey(name),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: listEquals(controller.model.task.phrase!.phraseList,
                controller.model.phraseOrdered)
            ? Colors.green
            : Colors.blue,
      ),
      padding: const EdgeInsets.all(18.0),
      alignment: Alignment.center,
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 32,
        ),
      ),
    );
  }
}
