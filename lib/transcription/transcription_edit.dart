import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/player_audio/player_audio_widget.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:transcribe/widget/input_checkbox.dart';
import 'package:transcribe/widget/input_checkbox_delete.dart';
import 'package:transcribe/widget/input_title.dart';
import 'package:transcribe/widget/input_users.dart';
import 'package:transcribe/widget/required_inform.dart';
import 'package:transcribe/widget/search_phrase.dart';
import 'package:transcribe/widget/search_team.dart';

import 'controller/transcription_edit_connector.dart';

class TranscriptionEdit extends StatefulWidget {
  final List<String> phraseCorrect;
  final List<String> phraseUnordened;
  final String phraseAudio;
  final Function(List<String>) onNewOrder;
  final Function() onSave;

  const TranscriptionEdit({
    Key? key,
    required this.phraseUnordened,
    required this.phraseAudio,
    required this.onNewOrder,
    required this.onSave,
    required this.phraseCorrect,
  }) : super(key: key);

  @override
  _TranscriptionEditState createState() => _TranscriptionEditState();
}

class _TranscriptionEditState extends State<TranscriptionEdit> {
  _TranscriptionEditState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transcribing'),
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
            const Align(
              alignment: Alignment.topLeft,
              child: Text('Move the boxes to order the sentence:'),
            ),
            Container(
              constraints: const BoxConstraints(
                maxHeight: 80,
              ),
              // color: Colors.yellow,
              child: ReorderableListView(
                // padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                onReorder: _onReorder,
                children: buildPhrase(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save this transcription in cloud',
        child: Icon(AppIconData.saveInCloud),
        onPressed: () {
          Navigator.pop(context);
          widget.onSave();
        },
      ),
    );
  }

  PlayerAudioWidget audio() {
    setState(() {});
    return PlayerAudioWidget(url: widget.phraseAudio);
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
    });
    // print('widget.phraseUnordened 1: ${widget.phraseUnordened}');
    List<String> listTemp = [];
    listTemp.addAll(widget.phraseUnordened);
    String resourceId = listTemp[oldIndex];
    listTemp.removeAt(oldIndex);
    listTemp.insert(newIndex, resourceId);
    // print('widget.phraseUnordened 2: ${widget.phraseUnordened}');
    widget.onNewOrder(listTemp);
    // print('widget.phraseUnordened 3: ${widget.phraseUnordened}');
  }

  List<Widget> buildPhrase() {
    List<Widget> temp = [];

    for (var item in widget.phraseUnordened) {
      temp.add(word(item));
    }
    return temp;
  }

  Widget word(String name) {
    return Container(
      key: ValueKey(name),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: listEquals(widget.phraseCorrect, widget.phraseUnordened)
            ? Colors.green
            : Colors.blue,
      ),
      padding: const EdgeInsets.all(18.0),
      // color: Colors.pink,
      alignment: Alignment.center,
      child: Text(
        name,
        style: TextStyle(
          color: Colors.black,
          fontSize: 32,
        ),
      ),
    );
  }
}
