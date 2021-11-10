import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:transcribe/user/controller/user_model.dart';

class UsersPage extends StatelessWidget {
  final List<UserModel> usersList;
  final int countPhrases;

  const UsersPage({
    Key? key,
    required this.usersList,
    required this.countPhrases,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Temos ${usersList.length} usuários e $countPhrases frases'),
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
    List<UserModel> usersListSorted = usersList;
    usersListSorted.sort((a, b) => a.displayName!.compareTo(b.displayName!));
    print('+++');
    for (var user in usersListSorted) {
      print('${user.displayName} | ${user.email} | ${user.id}');
    }
    print('---');
    for (var user in usersListSorted) {
      list.add(
        ListTile(
          title: Text('${user.displayName}'),
          subtitle:
              Text('email: ${user.email}\nid: ${user.id}\nuid: ${user.uid}'),
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
            Future<void> _copyToClipboard() async {
              await Clipboard.setData(ClipboardData(text: user.email));
            }

            _copyToClipboard();
            final snackBar = SnackBar(
                content: Text('Ok. O email: ${user.email} foi copiado'));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          },
        ),
      );
    }

    return list;
  }
}
