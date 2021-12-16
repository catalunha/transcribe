import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/data/model/user_model.dart';
import 'package:transcribe/app/modules/team/team_controller.dart';
import 'package:transcribe/app/theme/app_icon.dart';

class SearchUserWidget extends StatelessWidget {
  final Widget label;
  // final List<UserRef> userRefList;
  final IconData icon;
  final String messageTooltip;
  final bool required;
  final void Function(String) onDeleteUser;
  final void Function() search;
  const SearchUserWidget({
    Key? key,
    required this.label,
    // required this.userRefList,
    this.icon = AppIconData.list,
    required this.onDeleteUser,
    required this.search,
    this.required = false,
    this.messageTooltip = '',
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
                  TextButton.icon(
                    onPressed: () {
                      search();
                    },
                    icon: const Icon(
                      AppIconData.search,
                      color: Colors.white,
                    ),
                    label: label,
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
                      child: buildItens(context),
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

  Widget buildItens(context) {
    TeamController teamController = Get.find<TeamController>();

    return Obx(() {
      List<UserRef> studentList = teamController.model.students.values.toList();
      if (studentList.isNotEmpty) {
        List<Widget> listWidget = [];
        studentList.sort((a, b) => a.displayName!.compareTo(b.displayName!));
        for (var userRef in studentList) {
          listWidget.add(
            ListTile(
              leading: userRef.photoURL == null
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
              title: Text(userRef.displayName ?? 'Not name'),
              subtitle: Text(userRef.email),
              trailing: IconButton(
                icon: const Icon(AppIconData.delete),
                onPressed: () {
                  onDeleteUser(userRef.id);
                },
              ),
            ),
          );
        }
        return Column(
          children: listWidget,
        );
      } else {
        return const ListTile(
          leading: Icon(AppIconData.smile),
          title: Text("Ops. You don't have any student."),
        );
      }
    });
  }
}
