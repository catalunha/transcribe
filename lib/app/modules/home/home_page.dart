import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/modules/auth/auth_controller.dart';
import 'package:transcribe/app/modules/home/widget/information.dart';
import 'package:transcribe/app/modules/user/user_controller.dart';
import 'package:transcribe/app/theme/app_icon.dart';

class HomePage extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();

  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello, ${userController.userModel.displayName}.',
        ),
        actions: [
          popMenu(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (userController.userModel.accessType.contains('teacher')) ...[
              Card(
                child: ListTile(
                  leading: const Icon(Icons.people_alt),
                  title: const Text('Create a team'),
                  onTap: () async {
                    Get.toNamed('/team');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.text_fields_rounded),
                  title: const Text('Create a sentence'),
                  onTap: () async {
                    Get.toNamed('/phrase');
                  },
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.task),
                  title: const Text('Create a task'),
                  onTap: () async {
                    Get.toNamed('/task');
                  },
                ),
              ),
            ],
            Card(
              child: ListTile(
                leading: const Icon(Icons.multitrack_audio),
                title: const Text('Transcribe an audio'),
                onTap: () async {
                  Get.toNamed('/transcription');
                },
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
          // child: const Icon(Icons.ac_unit),
          child: Image.network(
            '${userController.userModel.photoURL}',
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
              onPressed: () async {
                await Get.to(() => const Information());
                Get.back();
              },
              icon: const Icon(AppIconData.info),
            ),
          ),
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Exit'),
              onPressed: () {
                authController.signOut();
              },
              icon: const Icon(AppIconData.exit),
            ),
          ),
        ];
      },
    );
  }
}
