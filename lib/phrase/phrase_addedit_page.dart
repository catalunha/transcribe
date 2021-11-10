// import 'package:classfrase/theme/app_icon.dart';
// import 'package:classfrase/theme/theme_app.dart';
// import 'package:classfrase/widget/input_checkbox.dart';
// import 'package:classfrase/widget/input_checkboxDelete.dart';
// import 'package:classfrase/widget/input_description.dart';
// import 'package:classfrase/widget/input_empty_box.dart';
// import 'package:classfrase/widget/input_title.dart';
// import 'package:classfrase/widget/required_inform.dart';
// import 'package:flutter/material.dart';
// import 'package:themed/themed.dart';

// import 'controller/phrase_addedit_page_connector.dart';
// import 'controller/phrase_model.dart';

// class PhraseAddEditPage extends StatefulWidget {
//   final bool phraseCurrentIsPublic;
//   final int publicPhraseQuota;
//   final int publicPhraseAmount;
//   final FormController formController;
//   final Function(PhraseModel) onSave;

//   const PhraseAddEditPage({
//     Key? key,
//     required this.formController,
//     required this.onSave,
//     required this.publicPhraseAmount,
//     required this.publicPhraseQuota,
//     required this.phraseCurrentIsPublic,
//   }) : super(key: key);

//   @override
//   _PhraseAddEditPageState createState() =>
//       _PhraseAddEditPageState(formController);
// }

// class _PhraseAddEditPageState extends State<PhraseAddEditPage> {
//   final FormController formController;

//   _PhraseAddEditPageState(this.formController);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.formController.phraseModel.id.isEmpty
//             ? 'Adicionar uma frase'
//             : 'Editar esta frase'),
//       ),
//       body: SingleChildScrollView(
//         child: Form(
//             key: widget.formController.formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 InputDescription(
//                   label: 'Informe a frase',
//                   required: true,
//                   initialValue: widget.formController.phraseModel.phrase,
//                   validator: widget.formController.validateRequiredText,
//                   onChanged: (value) {
//                     widget.formController.onChange(phrase: value);
//                   },
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     'Observação: Se a frase for modificada, após qualquer classificação, toda sua classificação será perdida.',
//                     style: TextStyle(color: ThemeApp.onBackground),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 InputTitle(
//                   label: 'Fonte desta frase',
//                   initialValue: widget.formController.phraseModel.font,
//                   onChanged: (value) {
//                     widget.formController.onChange(font: value);
//                   },
//                 ),
//                 InputTitle(
//                   label: 'Link para o diagrama online desta frase',
//                   initialValue: widget.formController.phraseModel.diagramUrl,
//                   onChanged: (value) {
//                     widget.formController.onChange(description: value);
//                   },
//                 ),
//                 InputTitle(
//                   label: 'Observador desta frase',
//                   messageTooltip:
//                       'Receba um ID (IDentificador) de alguêm que poderá observar sua classificação em tempo real.',
//                   initialValue: widget.formController.phraseModel.observer,
//                   onChanged: (value) {
//                     widget.formController.onChange(observer: value);
//                   },
//                 ),
//                 (widget.phraseCurrentIsPublic == true ||
//                         widget.publicPhraseAmount < widget.publicPhraseQuota)
//                     ? InputCheckBox(
//                         title: 'Publicar esta frase',
//                         subtitle: 'Marque para tornar esta frase pública.',
//                         icon: AppIconData.check,
//                         value: formController.phraseModel.isPublic,
//                         onChanged: (value) {
//                           formController.onChange(isPublic: value);
//                           setState(() {});
//                         },
//                       )
//                     : InputEmptyBox(
//                         title: 'Publicar esta frase',
//                         icon: AppIconData.check,
//                         widget: Text(
//                             'Sua cota de frases pública já acabou. Arquive ou desmarque como pública algumas frases.'),
//                       ),
//                 formController.phraseModel.id.isEmpty
//                     ? Container()
//                     : InputCheckBox(
//                         title: 'Arquivar esta frase',
//                         subtitle: 'Marque para arquivar esta frase.',
//                         icon: AppIconData.inbox,
//                         value: formController.phraseModel.isArchived,
//                         onChanged: (value) {
//                           formController.onChange(isArchived: value);
//                           setState(() {});
//                         },
//                       ),
//                 formController.phraseModel.id.isEmpty
//                     ? Container()
//                     : InputCheckBoxDelete(
//                         title: 'Apagar esta frase',
//                         subtitle: 'Remover permanentemente',
//                         value: widget.formController.phraseModel.isDeleted,
//                         onChanged: (value) {
//                           widget.formController.onChange(isDeleted: value);
//                           setState(() {});
//                         },
//                       ),
//                 RequiredInForm(
//                   message: 'Frase id: ${widget.formController.phraseModel.id}',
//                 ),
//               ],
//             )),
//       ),
//       floatingActionButton: FloatingActionButton(
//         tooltip: 'Salvar estes campos em núvem',
//         child: Icon(AppIconData.saveInCloud),
//         onPressed: () {
//           widget.formController.onCheckValidation();
//           if (widget.formController.isFormValid) {
//             Navigator.pop(context);
//             widget.onSave(widget.formController.phraseModel.copyWith());
//           }
//         },
//       ),
//     );
//   }
// }
