import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/theme/app_icon.dart';

import 'team_card.dart';
import 'team_controller.dart';

class TeamPage extends GetView<TeamController> {
  const TeamPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('My ${controller.list.length} teams')),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(child: buildItens(context)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create new team.',
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
        for (var model in controller.list) {
          listWidget.add(
            Container(
              key: ValueKey(model),
              child: TeamCard(
                team: model,
                widgetList: [
                  IconButton(
                    tooltip: 'Edit this team.',
                    icon: const Icon(AppIconData.edit),
                    onPressed: () {
                      controller.edit(model.id);
                    },
                  ),
                ],
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
          title: Text("Ops. You don't have any task."),
        );
      }
    });
  }
}
