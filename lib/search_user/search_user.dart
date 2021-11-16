import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:transcribe/user/controller/user_model.dart';

class SearchUser extends StatelessWidget {
  final List<UserRef> userRefList;
  final IconData icon;
  final String label;
  final String messageTooltip;
  final bool required;
  final bool? isFieldValid;
  final void Function(String) onDeleteUser;
  final void Function() search;
  const SearchUser({
    Key? key,
    required this.label,
    required this.userRefList,
    this.icon = AppIconData.list,
    required this.onDeleteUser,
    required this.search,
    this.required = false,
    this.messageTooltip = '',
    required this.isFieldValid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // IconButton(
                  //   onPressed: () {
                  //     search();
                  //   },
                  //   icon: Icon(AppIconData.search),
                  // ),
                  // Text(
                  //   label,
                  //   softWrap: true,
                  //   style: TextStyle(
                  //       // color: Colors.white,
                  //       ),
                  // ),
                  TextButton.icon(
                    onPressed: () {
                      search();
                    },
                    icon: const Icon(
                      AppIconData.search,
                      color: Colors.white,
                    ),
                    label: Text(
                      label,
                      softWrap: true,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  required
                      ? const Text(
                          ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        )
                      : Container(),
                ]),
            color: Colors.green.shade900,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  icon,
                  color: Colors.blue,
                ),
              ),
              Container(
                width: 1,
                height: 48,
                color: Colors.blue,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: userRefList
                            .map((e) => listTilePerson(userRef: e))
                            .toList(),
                      ),
                    ),
                    isFieldValid ?? true
                        ? Container()
                        : const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'This field cannot be empty.',
                              style: TextStyle(color: Colors.red, fontSize: 12),
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget listTilePerson({required UserRef? userRef}) {
    return ListTile(
      leading: userRef!.photoURL == null
          ? const Icon(AppIconData.undefined)
          : ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                userRef.photoURL!,
                height: 58,
                width: 58,
              ),
            ),
      title: Text(userRef.displayName ?? 'Not name'),
      subtitle: Text(userRef.email),
      trailing: IconButton(
        icon: const Icon(AppIconData.delete),
        onPressed: () {
          onDeleteUser(userRef.id);
        },
      ),
    );
  }
}
