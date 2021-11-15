import 'package:flutter/material.dart';
import 'package:transcribe/phrase/controller/phrase_addedit_connector.dart';

import 'home/controller/home_page_connector.dart';
import 'home/information.dart';
import 'login/controller/login_connector.dart';
import 'login/controller/splash_connector.dart';
import 'phrase/controller/phrase_list_connector.dart';
import 'task/controller/task_addedit_connector.dart';
import 'task/controller/task_list_connector.dart';
import 'task/controller/task_people_list_connector.dart';
import 'team/controller/team_addedit_connector.dart';
import 'team/team_page.dart';
import 'transcription/controller/transcription_edit_connector.dart';
import 'transcription/controller/transcription_list_connector.dart';
import 'users/controller/users_list_connector.dart';

class Routes {
  static final routes = {
    '/': (BuildContext context) => SplashConnector(),
    '/login': (BuildContext context) => LoginConnector(),
    '/home': (BuildContext context) => HomePageConnector(),
    '/information': (BuildContext context) => Information(),
    //team
    '/team_page': (BuildContext context) => const TeamPage(),
    // '/team_list': (BuildContext context) => const TeamListConnector(),
    '/team_addOrEdit': (BuildContext context) => TeamAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    //Users
    '/users_list': (BuildContext context) => const UsersListConnector(),
    //phrase
    '/phrase_list': (BuildContext context) => const PhraseListConnector(),
    '/phrase_addOrEdit': (BuildContext context) => PhraseAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    //task
    '/task_list': (BuildContext context) => const TaskListConnector(),
    '/task_addOrEdit': (BuildContext context) => TaskAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/task_people_list': (BuildContext context) => TaskPeopleListConnector(
          taskId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    // //transcription
    // '/transcription_list': (BuildContext context) =>
    //     const TranscriptionListConnector(),
    // '/transcription_edit': (BuildContext context) => TranscriptionEditConnector(
    //       addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
    //     ),
  };
}
