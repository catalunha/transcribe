import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:transcribe/user/controller/user_model.dart';

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
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              team.name,
              // textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          // Text(team.id),
          // Container(
          //   height: 1,
          //   color: Colors.blue,
          // ),
          Wrap(
            children: personList(
                context: context, userRefList: team.userMap.values.toList()),
          ),
          widgetList?.isNotEmpty != null
              ? Container(
                  height: 1,
                  color: Colors.green,
                )
              : Container(),
          Wrap(
            children: widgetList ?? [],
          )
        ],
      ),
    );
  }

  List<Widget> personList({
    var context,
    required List<UserRef> userRefList,
  }) {
    List<Widget> list = [];
    for (var userRef in userRefList) {
      list.add(
        Column(
          children: [
            IconButton(
              onPressed: () {
                Future<void> _copyToClipboard() async {
                  await Clipboard.setData(ClipboardData(text: userRef.email));
                }

                _copyToClipboard();
                final snackBar = SnackBar(
                    backgroundColor: Colors.green.shade900,
                    content: Text(
                      'This email ${userRef.email} is copied',
                      style: const TextStyle(color: Colors.white),
                    ));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              icon: userRef.photoURL == null
                  ? const Icon(AppIconData.undefined)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        userRef.photoURL!,
                        height: 58,
                        width: 58,
                      ),
                    ),
              iconSize: 58,
            ),
            nameUser(userRef),
          ],
        ),
      );
    }
    return list;
  }

  Text nameUser(UserRef userRef) {
    if (userRef.displayName != null && userRef.displayName!.length > 5) {
      return Text(
        '${userRef.displayName?.substring(0, 6)}...',
      );
    } else {
      return const Text('...');
    }
  }
}
