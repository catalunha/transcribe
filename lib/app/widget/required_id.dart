import 'package:flutter/material.dart';

class RequiredId extends StatelessWidget {
  final String message;
  final double sizedBoxHeight;
  const RequiredId({Key? key, this.message = '', this.sizedBoxHeight = 80})
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
                'Data with ',
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
              Text(' are required.',
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
