import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/modules/transcription/transcription_controller.dart';
import 'package:transcribe/app/theme/app_icon.dart';

class TranscriptionPage extends GetView<TranscriptionController> {
  const TranscriptionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select one tasks for solve'),
        actions: [
          IconButton(
            tooltip: 'Archived sentences',
            icon: const Icon(AppIconData.box),
            onPressed: () {
              controller.toArchived();
            },
          )
        ],
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
      if (controller.list.isNotEmpty) {
        List<Widget> list = [];

        for (var model in controller.list) {
          list.add(
            Container(
              key: ValueKey(model),
              child: Card(
                child: ListTile(
                  tileColor: model.isSolved ? Colors.green : null,
                  leading: model.task.isWritten
                      ? const Icon(AppIconData.digit)
                      : const Icon(AppIconData.order),
                  title: Text(
                    model.task.title,
                    style: const TextStyle(fontSize: 30),
                  ),
                  // subtitle: Text(model.id),
                  onTap: () {
                    controller.edit(model.id);
                  },
                  trailing: model.isSolved
                      ? IconButton(
                          tooltip: 'Archive this transcription',
                          icon: const Icon(AppIconData.inbox),
                          onPressed: () {
                            controller.archive(model.id, true);
                          },
                        )
                      : Container(
                          width: 1,
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
          title: Text("Ops. You don't have any transcription."),
        );
      }
    });
  }
}
