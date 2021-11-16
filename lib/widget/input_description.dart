import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';

class InputDescription extends StatelessWidget {
  final String label;
  final bool required;

  final IconData icon;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String) onChanged;
  const InputDescription({
    Key? key,
    required this.label,
    this.icon = AppIconData.description,
    this.initialValue,
    this.validator,
    this.controller,
    required this.onChanged,
    this.required = false,
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
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                label,
                style: const TextStyle(
                    // color: ThemeApp.onBackground,
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
                width: 10,
              ),
              Expanded(
                child: TextFormField(
                  // style: TextStyle(color: ThemeApp.onBackground,),
                  controller: controller,
                  initialValue: initialValue,
                  validator: validator,
                  onChanged: onChanged,
                  // style: AppTextStyles.input,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    // labelStyle: AppTextStyles.input,
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
