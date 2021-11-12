import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transcribe/theme/app_icon.dart';

import 'controller/team_list_connector.dart';
import 'controller/team_model.dart';
import 'team_card.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My teams'),
      ),
      body: TeamListConnector(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create new team.',
        child: Icon(AppIconData.addInCloud),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/team_addOrEdit',
            arguments: '',
          );
        },
      ),
    );
  }
}
