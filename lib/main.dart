import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'player/player_widget.dart';
import 'theme/app_images.dart';

void main() {
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transcribe',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      scrollBehavior: MyCustomScrollBehavior(),
      home: MyHomePage(
          title: 'Transcribe', frase: 'The three has tree branches .'),
    );
  }
}

const kUrl1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';

class MyHomePage extends StatefulWidget {
  final String title;
  final String frase;
  late List<String> list;
  late List<String> images = ['tree', 'three', 'branches'];
  MyHomePage({
    Key? key,
    required this.title,
    required this.frase,
  }) : super(key: key) {
    list = frase.split(' ');
    list.sort();
  }

  void onChangeOrder(List<String> ordened) {
    list = ordened;
  }

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Widget widgetApp(String name) {
  return Container(
    key: ValueKey(name),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.yellow,
    ),
    alignment: Alignment.center,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name,
      ),
    ),
  );
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text('Ouça o audio e/ou veja a imagem.'),
            // const Text(
            //   'Sample 1 ($kUrl1)',
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PlayerWidget(url: kUrl1),
                Image.asset(
                  AppImages.phrase,
                  width: 150,
                  height: 150,
                ),
              ],
            ),

            Container(
              color: Colors.orange,
              height: 10,
            ),
            Text('Coloque a frase na ordem'),
            // Text('Coloque a frase na ordem: ${widget.frase}'),
            Container(
              constraints: const BoxConstraints(
                maxHeight: 70,
              ),
              // color: Colors.yellow,
              child: ReorderableListView(
                padding: const EdgeInsets.all(10),
                scrollDirection: Axis.horizontal,
                onReorder: _onReorder,
                children: buildList(),
              ),
            ),
            Container(
              color: Colors.orange,
              height: 10,
            ),
            Text('Ouça e digite a frase:'),
            TextFormField(
              // style: TextStyle(color: ThemeApp.onBackground),
              // controller: controller,
              // initialValue: 'Ouça e digite a frase aqui',
              // validator: validator,
              // onChanged: onChanged,
              // style: AppTextStyles.input,
              decoration: InputDecoration(
                // labelText: "aqui...",
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(),
                ),
                //fillColor: Colors.green
              ),
            ),
            ..._buildWordImages(),
          ],
        ),
      ),
    );
  }

  List<Widget> buildList() {
    List<Widget> temp = [];

    for (var item in widget.list) {
      temp.add(widgetApp(item));
    }
    return temp;
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
    });
    List<String> listTemp = widget.list;
    String resourceId = listTemp[oldIndex];
    listTemp.removeAt(oldIndex);
    listTemp.insert(newIndex, resourceId);
    widget.onChangeOrder(listTemp);
  }

  List<Widget> _buildWordImages() {
    List<Widget> temp = [];

    for (var item in widget.list) {
      temp.add(widgetWordImg(item));
    }
    return temp;
  }

  Widget widgetWordImg(String item) {
    return ListTile(
      title: Text(
        item,
      ),
      trailing: widget.images.contains(item)
          ? Image.asset(
              "assets/images/$item.png",
              width: 150,
              height: 150,
            )
          : null,
    );
  }
}
