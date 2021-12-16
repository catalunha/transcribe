import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/modules/team/team_card.dart';
import 'package:transcribe/app/theme/app_icon.dart';

import 'search_team_controller.dart';

class SearchTeamPage extends GetView<SearchTeamController> {
  const SearchTeamPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text('You have ${controller.list.length} teams.')),
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
          list.add(Container(
            key: ValueKey(model),
            child: TeamCard(
              team: model,
              widgetList: [
                IconButton(
                  tooltip: 'Select this team.',
                  icon: const Icon(AppIconData.select),
                  onPressed: () {
                    controller.setTeam(model);
                  },
                ),
              ],
            ),
          ));
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
