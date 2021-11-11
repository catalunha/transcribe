import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transcribe/theme/app_icon.dart';

import 'controller/team_model.dart';
import 'team_card.dart';

class TeamList extends StatelessWidget {
  final List<TeamModel> teamList;

  const TeamList({
    Key? key,
    required this.teamList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My teams'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildItens(context),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create new team.',
        child: Icon(AppIconData.addInCloud),
        onPressed: () {
          // showDialog(
          //     context: context,
          //     builder: (BuildContext context) =>
          //         TeamAddEditPageConnector(addOrEditId: ''));
        },
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];

    for (var team in teamList) {
      list.add(Container(
        key: ValueKey(team),
        child: TeamCard(
          team: team,
          widgetList: [
            IconButton(
              tooltip: 'Edit this team.',
              icon: Icon(AppIconData.edit),
              onPressed: () {
                // showDialog(
                //     context: context,
                //     builder: (BuildContext context) =>
                //         TeamAddEditPageConnector(addOrEditId: team.id));
              },
            ),
          ],
        ),
      ));
    }
    if (list.isEmpty) {
      list.add(ListTile(
        leading: Icon(AppIconData.smile),
        title: Text("Ops. You don't have any team."),
      ));
    }
    return list;
  }
}
