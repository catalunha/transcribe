import 'package:flutter/material.dart';

import 'controller/phrase_model.dart';

class PhraseCard extends StatelessWidget {
  final PhraseModel phrase;
  final List<Widget>? widgetList;
  final Widget? trailing;
  const PhraseCard({
    Key? key,
    required this.phrase,
    this.widgetList,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                phrase.phraseList.join(' '),
                style: TextStyle(
                  // color: ThemeApp.onSurface,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                phrase.group,
                style: TextStyle(
                    // color: ThemeApp.onSurfaceLight,
                    // fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.green,
            ),
            // ListTile(
            //   // tileColor: ThemeApp.surfaceLight,
            //   title: Text(
            //     phrase.phraseList.join(' '),
            //     style: TextStyle(
            //       // color: ThemeApp.onSurface,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            //   subtitle: Text(
            //     phrase.group,
            //     style: TextStyle(
            //       // color: ThemeApp.onSurfaceLight,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            Wrap(
              children: widgetList ?? [],
            )
          ],
        ),
      ),
    );
  }
}
