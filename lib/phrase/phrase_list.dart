import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/phrase/phrase_card.dart';
import 'package:transcribe/theme/app_icon.dart';

import 'controller/phrase_model.dart';

class PhraseList extends StatelessWidget {
  final IList<PhraseModel> phraseIList;
  final Function(String) onArchive;

  const PhraseList({
    Key? key,
    required this.phraseIList,
    required this.onArchive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My sentences'),
        actions: [
          IconButton(
            tooltip: 'Archived sentences',
            icon: Icon(AppIconData.box),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/phrase_archived',
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

    for (var phrase in phraseIList) {
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
            IconButton(
              tooltip: 'Archive this sentence',
              icon: Icon(AppIconData.inbox),
              onPressed: () {
                onArchive(phrase.id);
              },
            )
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
