import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/modules/phrase/phrase_controller.dart';
import 'package:transcribe/app/theme/app_icon.dart';

class PhrasePage extends GetView<PhraseController> {
  const PhrasePage({
    Key? key,
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
            child: SingleChildScrollView(child: buildItens(context)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create new sentence.',
        child: const Icon(AppIconData.addInCloud),
        onPressed: () {
          controller.add();
        },
      ),
    );
  }

  Widget buildItens(context) {
    return Obx(() {
      if (controller.list.isNotEmpty) {
        List<Widget> listWidget = [];
        controller.list.sort((a, b) => a.group.compareTo(b.group));
        for (var model in controller.list) {
          listWidget.add(
            Card(
              child: ListTile(
                title: Text(model.phraseList.join(' ')),
                subtitle: Text(model.group),
                onTap: () {
                  controller.edit(model.id);
                },
                trailing: IconButton(
                    tooltip: 'Copy this sentence with...',
                    icon: const Icon(AppIconData.clone),
                    onPressed: () {
                      controller.addCopyWith(model.id);
                    }),
              ),
            ),
          );
        }
        return Column(
          children: listWidget,
        );
      } else {
        return const ListTile(
          leading: Icon(AppIconData.smile),
          title: Text("Ops. You don't have any sentence."),
        );
      }
    });
  }
}
