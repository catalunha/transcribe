import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:transcribe/user/controller/user_model.dart';

import 'controller/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final List<Widget>? widgetList;
  const TaskCard({
    Key? key,
    required this.task,
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
          SizedBox(
            width: double.infinity,
            child: Text(
              task.title,
              textAlign: TextAlign.start,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.blue,
            child: Text(
              task.phrase!.phraseList.join(' '),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          Wrap(
            children: personList(
                context: context,
                userRefList: task.team!.userMap.values.toList()),
          ),
          Container(
            height: 1,
            color: Colors.green,
          ),
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
