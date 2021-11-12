import 'package:flutter/material.dart';
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
  final List<String> phraseUnordened;
  final String phraseAudio;
  const TranscriptionEdit({
    Key? key,
    required this.phraseUnordened,
    required this.phraseAudio,
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
          children: [
            Text(widget.phraseAudio),
            Text(widget.phraseUnordened.join(' '))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Save this transcription in cloud',
        child: Icon(AppIconData.saveInCloud),
        onPressed: () {},
      ),
    );
  }
}
