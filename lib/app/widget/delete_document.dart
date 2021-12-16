import 'package:flutter/material.dart';
import 'package:transcribe/app/theme/app_icon.dart';

class DeleteDocument extends StatelessWidget {
  final Function() onPressed;

  const DeleteDocument({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: const Text('Delete this item', style: TextStyle()),
          color: Colors.green.shade900,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GestureDetector(
                onTap: onPressed,
                child: const Icon(
                  AppIconData.delete,
                  color: Colors.red,
                ),
              ),
            ),
            Container(
              width: 1,
              height: 48,
              color: Colors.blue,
            ),
            const Expanded(
                child: Center(
              child: Text(
                'click in left icon for delete forever',
                style: TextStyle(color: Colors.red),
              ),
            )),
          ],
        ),
      ],
    );
  }
}
