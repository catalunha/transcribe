import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/data/model/team_model.dart';
import 'package:transcribe/app/data/model/user_model.dart';

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
            child: Center(
              child: Text(
                team.name,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
          Wrap(
            children: personList(
                context: context, userRefList: team.students.values.toList()),
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
                Get.snackbar("Hi", "This email ${userRef.email} is copied");
              },
              icon: userRef.photoURL == null
                  ? const SizedBox(
                      height: 58,
                      width: 58,
                    )
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
    if (userRef.displayName != null && userRef.displayName!.length > 10) {
      return Text(
        '${userRef.displayName?.substring(0, 9)}',
      );
    } else {
      return Text('${userRef.displayName}');
    }
  }
}
