import 'package:flutter/material.dart';

class RequiredInForm extends StatelessWidget {
  final String message;
  final double sizedBoxHeight;
  const RequiredInForm({Key? key, this.message = '', this.sizedBoxHeight = 80})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text(
                'This data ',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              Text(
                ' * ',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              Text(' is required.',
                  style: TextStyle(
                    color: Colors.blue,
                  )),
            ],
          ),
          Text(message,
              style: const TextStyle(
                color: Colors.blue,
              )),
          SizedBox(
            height: sizedBoxHeight,
          ),
        ],
      ),
    );
  }
}
