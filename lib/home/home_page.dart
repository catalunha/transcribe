import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';

class HomePage extends StatelessWidget {
  final List<String> accessType;
  final String photoUrl;
  final String displayName;
  final VoidCallback signOut;
  const HomePage({
    Key? key,
    required this.photoUrl,
    required this.displayName,
    required this.signOut,
    required this.accessType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello, $displayName.',
        ),
        actions: [
          popMenu(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (accessType.contains('teacher')) ...[
              Card(
                child: ListTile(
                  leading: const Icon(Icons.people_alt),
                  title: const Text('Create a team'),
                  onTap: () async {
                    Navigator.pushNamed(
                      context,
                      '/team_page',
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.text_fields_rounded),
                  title: Text('Create a sentence'),
                  onTap: () async {
                    Navigator.pushNamed(
                      context,
                      '/phrase_list',
                    );
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: Icon(Icons.task),
                  title: Text('Create a task'),
                  onTap: () async {
                    Navigator.pushNamed(
                      context,
                      '/task_list',
                    );
                  },
                ),
              ),
            ],
            Card(
              child: ListTile(
                leading: Icon(Icons.multitrack_audio),
                title: Text('Transcribe an audio'),
              ),
            )
          ],
        ),
      ),
    );
  }

  PopupMenuButton<dynamic> popMenu() {
    return PopupMenuButton(
      child: Tooltip(
        message: 'click here to others options',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            photoUrl,
            height: 58,
            width: 58,
          ),
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Information'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/information');
              },
              icon: const Icon(AppIconData.info),
            ),
          ),
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Exit'),
              onPressed: () {
                signOut();
                Navigator.pop(context);
              },
              icon: const Icon(AppIconData.exit),
            ),
          ),
        ];
      },
    );
  }
}
