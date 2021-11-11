import 'package:flutter/material.dart';
import 'package:transcribe/phrase/phrase_card.dart';
import 'package:transcribe/theme/app_icon.dart';

import 'controller/phrase_model.dart';

class PhraseList extends StatelessWidget {
  final List<PhraseModel> phraseList;

  const PhraseList({
    Key? key,
    required this.phraseList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My sentences'),
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
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create new sentence.',
        child: Icon(AppIconData.addInCloud),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/phrase_addOrEdit',
            arguments: '',
          );
        },
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];

    for (var phrase in phraseList) {
      list.add(Container(
        key: ValueKey(phrase),
        child: PhraseCard(
          phrase: phrase,
          widgetList: [
            IconButton(
              tooltip: 'Edit this sentence.',
              icon: Icon(AppIconData.edit),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/phrase_addOrEdit',
                  arguments: phrase.id,
                );
              },
            ),
          ],
        ),
      ));
    }
    if (list.isEmpty) {
      list.add(ListTile(
        leading: Icon(AppIconData.smile),
        title: Text("Ops. You don't have any sentence."),
      ));
    }
    return list;
  }
}
