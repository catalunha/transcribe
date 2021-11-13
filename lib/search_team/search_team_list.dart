import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transcribe/team/controller/team_model.dart';
import 'package:transcribe/team/team_card.dart';
import 'package:transcribe/theme/app_icon.dart';

class SearchTeamList extends StatelessWidget {
  final IList<TeamModel> teamIList;
  final Function(String) onSetTeam;

  const SearchTeamList({
    Key? key,
    required this.teamIList,
    required this.onSetTeam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: buildItens(context),
          ),
        ),
      ),
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
              tooltip: 'Select this team.',
              icon: Icon(AppIconData.select),
              onPressed: () {
                onSetTeam(team.id);
                Navigator.pop(context);
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
