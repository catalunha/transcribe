import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';

import 'controller/team_model.dart';
import 'team_card.dart';

class TeamList extends StatelessWidget {
  final IList<TeamModel> teamIList;

  const TeamList({
    Key? key,
    required this.teamIList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: buildItens(context),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];

    for (var team in teamIList) {
      list.add(Container(
        key: ValueKey(team),
        child: TeamCard(
          team: team,
          widgetList: [
            IconButton(
              tooltip: 'Edit this team.',
              icon: Icon(AppIconData.edit),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/team_addOrEdit',
                  arguments: team.id,
                );
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
