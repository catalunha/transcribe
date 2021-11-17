import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/player_audio/player_audio_widget.dart';
import 'package:transcribe/theme/app_icon.dart';

class TranscriptionEdit extends StatefulWidget {
  final List<String> phraseList;
  final bool isWritten;
  final String phraseWritten;

  final List<String> phraseOrdered;
  final String phraseAudio;
  final Function(List<String>) onPhraseOrdering;
  final Function(String) onPhraseTyping;

  final Function() onSave;

  const TranscriptionEdit({
    Key? key,
    required this.phraseOrdered,
    required this.phraseAudio,
    required this.onPhraseOrdering,
    required this.onSave,
    required this.phraseList,
    required this.isWritten,
    required this.phraseWritten,
    required this.onPhraseTyping,
  }) : super(key: key);

  @override
  _TranscriptionEditState createState() => _TranscriptionEditState();
}

class _TranscriptionEditState extends State<TranscriptionEdit> {
  _TranscriptionEditState();
  final TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController.text = widget.phraseWritten;
  }

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
            if (widget.isWritten) ...typing() else ...ordering(),
            listEquals(widget.phraseList, widget.phraseOrdered) ||
                    (widget.phraseList.join(' ') == widget.phraseWritten)
                ? const Center(
                    child: Text(
                      'Good job. Save now please !',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 30,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save this transcription in cloud',
        child: const Icon(AppIconData.saveInCloud),
        onPressed: () {
          Navigator.pop(context);
          widget.onSave();
        },
      ),
    );
  }

  List<Widget> typing() {
    return [
      const Align(
        alignment: Alignment.topLeft,
        child: Text('And type the sentence:'),
      ),
      TextField(
        style: TextStyle(fontSize: 32),
        controller: textEditingController,
        onChanged: (value) {
          widget.onPhraseTyping(value);
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
        // color: Colors.yellow,
        child: ReorderableListView(
          // padding: const EdgeInsets.all(10),
          scrollDirection: Axis.horizontal,
          onReorder: _onReorder,
          children: buildPhrase(),
        ),
      ),
    ];
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
    // print('widget.phraseOrdered 1: ${widget.phraseOrdered}');
    List<String> listTemp = [];
    listTemp.addAll(widget.phraseOrdered);
    String resourceId = listTemp[oldIndex];
    listTemp.removeAt(oldIndex);
    listTemp.insert(newIndex, resourceId);
    // print('widget.phraseOrdered 2: ${widget.phraseOrdered}');
    widget.onPhraseOrdering(listTemp);
    // print('widget.phraseOrdered 3: ${widget.phraseOrdered}');
  }

  List<Widget> buildPhrase() {
    List<Widget> temp = [];

    for (var item in widget.phraseOrdered) {
      temp.add(word(item));
    }
    return temp;
  }

  Widget word(String name) {
    return Container(
      key: ValueKey(name),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: listEquals(widget.phraseList, widget.phraseOrdered)
            ? Colors.green
            : Colors.blue,
      ),
      padding: const EdgeInsets.all(18.0),
      // color: Colors.pink,
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
