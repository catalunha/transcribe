import 'package:get/get.dart';
import 'package:transcribe/app/modules/phrase/phrase_addedit.dart';
import 'package:transcribe/app/modules/phrase/phrase_controller.dart';
import 'package:transcribe/app/modules/phrase/phrase_page.dart';
import 'package:transcribe/app/modules/search_phrase/search_phrase_controller.dart';
import 'package:transcribe/app/modules/search_phrase/search_phrase_page.dart';
import 'package:transcribe/app/modules/search_team/search_team_controller.dart';
import 'package:transcribe/app/modules/search_team/search_team_page.dart';
import 'package:transcribe/app/modules/task/people_on_task.dart';
import 'package:transcribe/app/modules/task/task_addedit.dart';
import 'package:transcribe/app/modules/task/task_archived_page.dart';
import 'package:transcribe/app/modules/task/task_controller.dart';
import 'package:transcribe/app/modules/task/task_page.dart';
import 'package:transcribe/app/modules/transcription/transcription_archived_page.dart';
import 'package:transcribe/app/modules/transcription/transcription_controller.dart';
import 'package:transcribe/app/modules/transcription/transcription_edit.dart';
import 'package:transcribe/app/modules/transcription/transcription_page.dart';
import 'modules/auth/auth_controller.dart';
import 'modules/search_user/search_user_page.dart';
import 'modules/search_user/search_user_controller.dart';
import 'modules/team/team_addedit.dart';
import 'modules/team/team_controller.dart';
import 'modules/team/team_page.dart';

import 'modules/home/home_page.dart';
import 'modules/login/login_page.dart';
import 'modules/auth/auth_page.dart';

abstract class RoutesPaths {
  static const auth = '/';
  static const login = '/login';
  static const home = '/home';
  static const team = '/team';
  static const teamAddEdit = '/teamAddEdit';
  static const searchUser = '/searchUser';
  static const phrase = '/phrase';
  static const phraseAddEdit = '/phraseAddEdit';
  static const task = '/task';
  static const taskArchived = '/taskArchived';
  static const taskAddEdit = '/taskAddEdit';
  static const taskPeopleOnTask = '/taskPeopleOnTask';
  static const searchTeam = '/searchTeam';
  static const searchPhrase = '/searchPhrase';
  static const transcription = '/transcription';
  static const transcriptionEdit = '/transcriptionEdit';
  static const transcriptionArchived = '/transcriptionArchived';
}

class RoutesPages {
  static final pageList = [
    GetPage(
      name: RoutesPaths.auth,
      page: () => const AuthPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: RoutesPaths.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: RoutesPaths.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: RoutesPaths.team,
      page: () => const TeamPage(),
      binding: TeamBinding(),
    ),
    GetPage(
      name: RoutesPaths.teamAddEdit,
      page: () => const TeamAddEdit(),
    ),
    GetPage(
      name: RoutesPaths.searchUser,
      page: () => SearchUserPage(),
      binding: SearchUserBinding(),
    ),
    GetPage(
      name: RoutesPaths.phrase,
      page: () => const PhrasePage(),
      binding: PhraseBinding(),
    ),
    GetPage(
      name: RoutesPaths.phraseAddEdit,
      page: () => const PhraseAddEdit(),
    ),
    GetPage(
      name: RoutesPaths.task,
      page: () => const TaskPage(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: RoutesPaths.taskArchived,
      page: () => const TaskArchivedPage(),
    ),
    GetPage(
      name: RoutesPaths.taskAddEdit,
      page: () => const TaskAddEdit(),
    ),
    GetPage(
      name: RoutesPaths.taskPeopleOnTask,
      page: () => const PeopleOnTask(),
    ),
    GetPage(
      name: RoutesPaths.searchTeam,
      page: () => const SearchTeamPage(),
      binding: SearchTeamBinding(),
    ),
    GetPage(
      name: RoutesPaths.searchPhrase,
      page: () => const SearchPhrasePage(),
      binding: SearchPhraseBinding(),
    ),
    GetPage(
      name: RoutesPaths.transcription,
      page: () => const TranscriptionPage(),
      binding: TranscriptionBinding(),
    ),
    GetPage(
      name: RoutesPaths.transcriptionEdit,
      page: () => const TranscriptionEdit(),
    ),
    GetPage(
      name: RoutesPaths.transcriptionArchived,
      page: () => const TranscriptionArchivedPage(),
    ),
  ];
}
