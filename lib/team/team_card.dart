import 'package:flutter/material.dart';

import 'controller/team_model.dart';

class TeamCard extends StatelessWidget {
  final TeamModel team;
  final List<Widget>? widgetList;
  const TeamCard({
    Key? key,
    required this.team,
    this.widgetList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            team.name,
          ),
          Container(
            height: 1,
            color: Colors.blue,
          ),
          Text('fotos do team'),
          Container(
            height: 1,
            color: Colors.green,
          ),
          Wrap(
            children: widgetList ?? [],
          )
        ],
      ),
    );
  }
}
