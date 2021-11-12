import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transcribe/phrase/controller/phrase_model.dart';
import 'package:transcribe/phrase/controller/phrase_model.dart';
import 'package:transcribe/phrase/phrase_card.dart';
import 'package:transcribe/theme/app_icon.dart';

class SearchPhraseList extends StatelessWidget {
  final List<PhraseModel> phraseList;
  final Function(String) onSetPhrase;

  const SearchPhraseList({
    Key? key,
    required this.phraseList,
    required this.onSetPhrase,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: buildItens(context),
          ),
        ),
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
              tooltip: 'Select this phrase.',
              icon: Icon(AppIconData.select),
              onPressed: () {
                onSetPhrase(phrase.id);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ));
    }
    if (list.isEmpty) {
      list.add(ListTile(
        leading: Icon(AppIconData.smile),
        title: Text("Ops. You don't have any phrase."),
      ));
    }
    return list;
  }
}
