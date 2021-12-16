import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/theme/app_icon.dart';

class SearchTeamWidget extends StatelessWidget {
  final String label;
  final Widget teamWidget;
  final IconData icon;
  final String messageTooltip;
  final bool required;
  const SearchTeamWidget({
    Key? key,
    required this.label,
    required this.teamWidget,
    this.icon = AppIconData.people,
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
                      Get.toNamed('/searchTeam');
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
                  // flex: 15,
                  child: teamWidget),
            ],
          ),
        ],
      ),
    );
  }
}
