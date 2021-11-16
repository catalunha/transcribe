import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';

class InputCheckBoxDelete extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool? value;
  final void Function(bool?) onChanged;

  const InputCheckBoxDelete(
      {Key? key,
      required this.title,
      required this.onChanged,
      this.value,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: Text(title,
              style: const TextStyle(
                  // color: ThemeApp.onBackground,
                  )),
          color: Colors.green.shade900,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(
                AppIconData.delete,
                color: Colors.blue,
              ),
            ),
            Container(
              width: 1,
              height: 48,
              color: Colors.blue,
            ),
            Expanded(
              child: CheckboxListTile(
                // activeColor: AppColors.delete,
                checkColor: Colors.black,
                selectedTileColor: Colors.yellow,
                selected: value!,
                controlAffinity: ListTileControlAffinity.leading,
                title: value!
                    ? Text(
                        subtitle,
                        style: const TextStyle(color: Colors.black),
                      )
                    : Text(subtitle),
                onChanged: onChanged,
                value: value,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
