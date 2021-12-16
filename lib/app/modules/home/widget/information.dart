import 'package:flutter/material.dart';
import 'package:transcribe/app/theme/app_icon.dart';
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

Este aplicativo nasceu de uma parceria entre a familia Catalunha e o Prof. Fabio Costa no processo de ensino e aprendizagem do inglês.
      ''',
              ),
            ),
            ListTile(
              title: const Text('Para um rápido tutorial, clique aqui.'),
              leading: const Icon(AppIconData.undefined),
              onTap: () async {
                bool can = await canLaunch(
                    'https://docs.google.com/document/d/1FwOW8nE71i-S0K5dsno7RaQyGuTfR3-vCv8UCHO4eyw/edit?usp=sharing');
                if (can) {
                  await launch(
                      'https://docs.google.com/document/d/1FwOW8nE71i-S0K5dsno7RaQyGuTfR3-vCv8UCHO4eyw/edit?usp=sharing');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
