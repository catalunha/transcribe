import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/phrase/phrase_card.dart';
import 'package:transcribe/theme/app_icon.dart';

import 'controller/phrase_model.dart';

class PhraseArchivedList extends StatelessWidget {
  final IList<PhraseModel> phraseIList;
  final Function(String) onArchive;
  final Function(String) onDelete;

  const PhraseArchivedList({
    Key? key,
    required this.phraseIList,
    required this.onArchive,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My sentences'),
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
        child: const Icon(AppIconData.addInCloud),
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
              tooltip: 'unarchive this sentence',
              icon: const Icon(AppIconData.outbox),
              onPressed: () {
                onArchive(phrase.id);
              },
            ),
            IconButton(
              tooltip: 'delete this sentence',
              icon: const Icon(AppIconData.delete),
              onPressed: () {
                onDelete(phrase.id);
              },
            )
          ],
        ),
      ));
    }
    if (list.isEmpty) {
      list.add(const ListTile(
        leading: Icon(AppIconData.smile),
        title: Text("Ops. You don't have any sentence."),
      ));
    }
    return list;
  }
}
