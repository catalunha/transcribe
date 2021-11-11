import 'package:flutter/material.dart';

import 'home/controller/home_page_connector.dart';
import 'home/information.dart';
import 'login/controller/login_connector.dart';
import 'login/controller/splash_connector.dart';
import 'team/controller/team_addedit_connector.dart';
import 'team/controller/team_list_connector.dart';
import 'users/controller/users_list_connector.dart';

class Routes {
  static final routes = {
    '/': (BuildContext context) => SplashConnector(),
    '/login': (BuildContext context) => LoginConnector(),
    '/home': (BuildContext context) => HomePageConnector(),
    '/information': (BuildContext context) => Information(),
    //team
    '/team_list': (BuildContext context) => const TeamListConnector(),
    '/team_addOrEdit': (BuildContext context) => TeamAddEditConnector(
          addOrEditId: ModalRoute.of(context)!.settings.arguments.toString(),
        ),
    //Users
    '/users_list': (BuildContext context) => const UsersListConnector(),
  };
}
