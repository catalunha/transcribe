import 'package:flutter/material.dart';
import 'package:transcribe/app/theme/app_icon.dart';

class InputTitle extends StatelessWidget {
  final IconData icon;
  final String label;
  final String messageTooltip;
  final bool required;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String) onChanged;
  const InputTitle({
    Key? key,
    required this.label,
    this.icon = AppIconData.title,
    this.initialValue,
    this.validator,
    this.controller,
    required this.onChanged,
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
                  Text(
                    label,
                    softWrap: true,
                    style: const TextStyle(),
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
                child: TextFormField(
                  style: const TextStyle(),
                  controller: controller,
                  initialValue: initialValue,
                  validator: validator,
                  onChanged: onChanged,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
