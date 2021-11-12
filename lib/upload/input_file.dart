import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class InputFile extends StatelessWidget {
  final String label;
  final VoidCallback selectLocalFile;
  final String selectedLocalFileName;
  final VoidCallback uploadingFile;
  final double percentageOfUpload;
  final String urlForDownload;
  final bool requiredField;

  const InputFile({
    Key? key,
    required this.label,
    required this.selectLocalFile,
    required this.selectedLocalFileName,
    required this.uploadingFile,
    required this.percentageOfUpload,
    required this.urlForDownload,
    required this.requiredField,
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
            color: Colors.green.shade900,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label),
                requiredField
                    ? Text(
                        ' *',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  AppIconData.attachFile,
                  color: Colors.blue,
                ),
              ),
              Container(
                width: 1,
                height: 48,
                color: Colors.blueAccent,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(AppIconData.search),
                      title: Text('1º Select the file'),
                      subtitle: Text(selectedLocalFileName),
                      onTap: selectLocalFile,
                    ),
                    ListTile(
                      leading: Icon(AppIconData.saveInCloud),
                      title: Text('2º Send for clound'),
                      subtitle: percentageOfUpload > 0
                          ? Text('Sending...')
                          : Text(''),
                      onTap: uploadingFile,
                      trailing:
                          Text('${percentageOfUpload.toStringAsFixed(2)}'),
                    ),
                    ListTile(
                      leading: Icon(AppIconData.linkOn),
                      title: Text('3º Check de audio in web'),
                      subtitle: Text(urlForDownload),
                      onTap: () async {
                        if (urlForDownload.isNotEmpty) {
                          bool can = await canLaunch(urlForDownload);
                          if (can) {
                            await launch(urlForDownload);
                          } else {
                            print('launch nao possivel');
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Divider(
          //   height: 1,
          //   thickness: 1,
          //   color: Colors.white,
          // ),
        ],
      ),
    );
  }
}
