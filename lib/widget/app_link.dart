import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class AppLink extends StatelessWidget {
  final String? url;
  final String? tooltipMsg;
  final IconData? icon;
  const AppLink({
    Key? key,
    required this.url,
    this.icon = AppIconData.linkOn,
    this.tooltipMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return url != null && url!.isNotEmpty
        ? IconButton(
            tooltip: tooltipMsg,
            onPressed: () async {
              bool can = await canLaunch(url!);
              if (can) {
                await launch(url!);
              }
            },
            icon: Icon(icon))
        : Container(
            width: 1,
          );
  }
}
