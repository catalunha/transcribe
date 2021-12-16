import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/modules/search_phrase/search_phrase_controller.dart';

class SearchPhrasePage extends GetView<SearchPhraseController> {
  const SearchPhrasePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('You have ${controller.list.length} phrases.')),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: buildItens(context),
        ),
      ),
    );
  }

  Widget buildItens(context) {
    return Obx(() {
      if (controller.list.isNotEmpty) {
        List<Widget> list = [];

        for (var model in controller.list) {
          list.add(
            ListTile(
              title: Text(model.phraseList.join(' ')),
              subtitle: Text(model.group),
              onTap: () {
                controller.setPhrase(model);
              },
            ),
          );
        }
        return Column(
          children: list,
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }
}
