import 'package:flutter/material.dart';
import 'package:transcribe/phrase/controller/phrase_addedit_connector.dart';

import 'home/controller/home_page_connector.dart';
import 'home/information.dart';
import 'login/controller/login_connector.dart';
import 'login/controller/splash_connector.dart';
import 'phrase/controller/phrase_list_archived_connector.dart';
import 'phrase/controller/phrase_list_connector.dart';
import 'search_user/controller/search_user_list_connector.dart';
import 'task/controller/task_addedit_connector.dart';
import 'task/controller/task_list_archived_connector.dart';
import 'task/controller/task_list_connector.dart';
import 'task/controller/task_people_list_connector.dart';
import 'team/controller/team_addedit_connector.dart';
import 'team/team_page.dart';
import 'transcription/controller/transcription_edit_connector.dart';
import 'transcription/controller/transcription_list_archived_connector.dart';
import 'transcription/controller/transcription_list_connector.dart';

class Routes {
  static final routes = {
    //login
    '/': (BuildContext context) => const SplashConnector(),
    '/login': (BuildContext context) => const LoginConnector(),
    //home
    '/home': (BuildContext context) => const HomePageConnector(),
    '/information': (BuildContext context) => const Information(),
    //team
    '/team_page': (BuildContext context) => const TeamPage(),
    '/team_addOrEdit': (BuildContext context) => TeamAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    //Users
    '/search_user_list': (BuildContext context) =>
        const SearchUserListConnector(),
    //phrase
    '/phrase_list': (BuildContext context) => const PhraseListConnector(),
    '/phrase_addOrEdit': (BuildContext context) => PhraseAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/phrase_archived': (BuildContext context) =>
        const PhraseListArchivedConnector(),
    //task
    '/task_list': (BuildContext context) => const TaskListConnector(),
    '/task_addOrEdit': (BuildContext context) => TaskAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/task_people_list': (BuildContext context) => TaskPeopleListConnector(
          taskId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/task_archived': (BuildContext context) =>
        const TaskListArchivedConnector(),
    //transcription
    '/transcription_list': (BuildContext context) =>
        const TranscriptionListConnector(),
    '/transcription_edit': (BuildContext context) => TranscriptionEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    '/transcription_archived': (BuildContext context) =>
        const TranscriptionListArchivedConnector(),
  };
}
