// import 'package:classfrase/phrase/phrase_card.dart';
// import 'package:classfrase/theme/app_icon.dart';
// import 'package:flutter/material.dart';

// import 'controller/phrase_model.dart';

// class PhraseArchivedPage extends StatelessWidget {
//   final List<PhraseModel> phraseList;
//   final Function(String) onUnArchivePhrase;

//   const PhraseArchivedPage({
//     Key? key,
//     required this.phraseList,
//     required this.onUnArchivePhrase,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Frases arquivadas'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: buildItens(context),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   List<Widget> buildItens(context) {
//     List<Widget> list = [];

//     for (var phrase in phraseList) {
//       list.add(Container(
//         key: ValueKey(phrase),
//         child: PhraseCard(
//           phrase: phrase,
//           widgetList: [
//             IconButton(
//               tooltip: 'Desarquivar esta frase',
//               icon: Icon(AppIconData.outbox),
//               onPressed: () {
//                 onUnArchivePhrase(phrase.id);
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       ));
//     }
//     if (list.isEmpty) {
//       list.add(ListTile(
//         leading: Icon(AppIconData.smile),
//         title: Text('Ops. Vc não arquivou nenhuma frase.'),
//       ));
//     }
//     return list;
//   }
// }
