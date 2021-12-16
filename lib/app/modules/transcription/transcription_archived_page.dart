import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/theme/app_icon.dart';

import 'transcription_controller.dart';

class TranscriptionArchivedPage extends GetView<TranscriptionController> {
  const TranscriptionArchivedPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your transcriptions archived'),
        // backgroundColor: Colors.orange,
        foregroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: buildItens(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildItens(context) {
    return Obx(() {
      if (controller.listArchived.isNotEmpty) {
        List<Widget> list = [];

        for (var model in controller.listArchived) {
          list.add(
            Container(
              key: ValueKey(model),
              child: Card(
                child: ListTile(
                  tileColor: model.isSolved ? Colors.green : null,
                  leading: IconButton(
                    tooltip: 'delete this sentence',
                    icon: const Icon(AppIconData.delete),
                    onPressed: () {
                      controller.delete(model.id);
                    },
                  ),
                  title: Text(
                    model.task.title,
                    style: const TextStyle(fontSize: 30),
                  ),
                  trailing: IconButton(
                    tooltip: 'unarchive this sentence',
                    icon: const Icon(AppIconData.outbox),
                    onPressed: () {
                      controller.archive(model.id, false);
                    },
                  ),
                ),
              ),
            ),
          );
        }
        return Column(
          children: list,
        );
      } else {
        return const ListTile(
          leading: Icon(AppIconData.smile),
          title: Text("Ops. You don't have any archived transcriptions."),
        );
      }
    });
  }
}
