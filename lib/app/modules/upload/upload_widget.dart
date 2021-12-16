import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/modules/upload/upload_controller.dart';
import 'package:transcribe/app/theme/app_icon.dart';

class UploadWidget extends StatelessWidget {
  UploadController controller = Get.put(UploadController());
  final String label;
  final bool requiredField;
  final Function(String) getUrl;
  final String pathInFirestore;
  final String initialUrl;

  UploadWidget({
    Key? key,
    required this.label,
    required this.requiredField,
    required this.getUrl,
    required this.pathInFirestore,
    required this.initialUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.checkFileInStorage(initialUrl);
    controller.pathInFirestore = pathInFirestore;
    controller.externalGetUrl = getUrl;

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
                    ? const Text(
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
                child: GestureDetector(
                  onTap: () async {
                    controller.startUpload();
                  },
                  child: const Icon(
                    AppIconData.search,
                    color: Colors.blue,
                  ),
                ),
              ),
              Container(
                width: 1,
                height: 48,
                color: Colors.blueAccent,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      Widget info = const SizedBox();
                      if (controller.uploadStage.value ==
                          UploadStage.existFileInStorage) {
                        info = const Text(
                            '* There is already an audio registered. If you want to change this click on the icon and look for another file.');
                      } else {
                        info = Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Stage: ${controller.uploadStage.value.name}'),
                            Text('File name: ${controller.fileName.value}'),
                            Text(
                                'Percentage: ${controller.uploadPercentage} %'),
                          ],
                        );
                      }
                      return info;
                    }),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
