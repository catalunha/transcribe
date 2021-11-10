import 'package:flutter/material.dart';
import 'package:transcribe/theme/app_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class Information extends StatelessWidget {
  const Information({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                '''
Olá,

Este aplicativo nasceu de uma parceria entre o Prof Fabio Costa e a familia Catalunha no processo de ensino e aprendizagem do inglês.
      ''',
                // style: AppTextStyles.titleRegular,
              ),
            ),
            ListTile(
              title: const Text('Para um rápido tutorial, clique aqui.'),
              leading: const Icon(AppIconData.undefined),
              onTap: () async {
                bool can = await canLaunch('https://www.google.com.br');
                if (can) {
                  await launch('https://www.google.com.br');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
