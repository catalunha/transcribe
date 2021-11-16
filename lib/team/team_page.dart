import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';

import 'controller/team_list_connector.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My teams'),
      ),
      body: const TeamListConnector(),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Create new team.',
        child: const Icon(AppIconData.addInCloud),
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
