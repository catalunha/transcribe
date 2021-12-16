import 'package:flutter/material.dart';
import 'package:transcribe/app/theme/app_icon.dart';

class InputCheckBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  final bool? value;
  final void Function(bool?) onChanged;

  const InputCheckBox(
      {Key? key,
      required this.title,
      required this.onChanged,
      this.value,
      required this.subtitle,
      this.icon = AppIconData.check})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: Text(
            title,
          ),
          color: Colors.green.shade900,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
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
            Expanded(
              child: CheckboxListTile(
                title: Text(subtitle),
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
