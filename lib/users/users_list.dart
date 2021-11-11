import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:transcribe/user/controller/user_model.dart';

class UsersList extends StatelessWidget {
  final List<String> userIdListInTeam;
  final List<UserRef> userRefList;
  final Function(bool, String) onAddOrDeleteUser;

  const UsersList({
    Key? key,
    required this.userRefList,
    required this.onAddOrDeleteUser,
    required this.userIdListInTeam,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('We have ${userRefList.length} users in app'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: buildItens(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildItens(context) {
    List<Widget> list = [];
    List<UserRef> userRefListSorted = userRefList;
    userRefListSorted.sort((a, b) => a.displayName!.compareTo(b.displayName!));
    print('---');
    for (var user in userRefListSorted) {
      list.add(
        ListTile(
          tileColor: userIdListInTeam.contains(user.id) ? Colors.green : null,
          title: Text('${user.displayName}'),
          subtitle: Text(user.email),
          leading: user.photoURL == null
              ? Icon(AppIconData.undefined)
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    user.photoURL!,
                    height: 58,
                    width: 58,
                  ),
                ),
          onTap: () {
            onAddOrDeleteUser(!userIdListInTeam.contains(user.id), user.id);
          },
          trailing: IconButton(
            icon: const Icon(AppIconData.copy),
            onPressed: () {
              Future<void> _copyToClipboard() async {
                await Clipboard.setData(ClipboardData(text: user.email));
              }

              _copyToClipboard();
              final snackBar = SnackBar(
                  backgroundColor: Colors.green.shade900,
                  content: Text(
                    'This email ${user.email} is copied',
                    style: TextStyle(color: Colors.white),
                  ));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          ),
        ),
      );
    }

    return list;
  }
}
