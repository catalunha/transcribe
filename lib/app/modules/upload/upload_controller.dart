import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

enum UploadStage {
  analyzingStorage,
  existFileInStorage,
  notExistFileInStorage,
  startingUpload,
  searchingFileLocally,
  foundLocallyFile,
  erroFetchFileLocally,
  connectingWithStorage,
  sendingFileToStorage,
  errorSendingFileToStorage,
  shippingCompleted,
  gettingRrl,
  uploadCompleted,
}

extension UploadStageExtension on UploadStage {
  String get name {
    return [
      'analyzing storage',
      'exist file on storage',
      'not exist file in storage',
      'starting upload',
      'Searching File Locally',
      'Found Locally file',
      'error fetch File Locally',
      'connecting with Storage',
      'sending file to storage',
      'Error When Sending File To Storage',
      'shipping completed',
      'getting url',
      'upload completed',
    ][index];
  }
  // String name() {
  //   return toString().split('.').last;
  // }
}

class UploadController extends GetxController {
  Rx<String> fileName = ''.obs;
  Rx<int> uploadPercentage = 0.obs;
  Rx<String> urlForDownload = ''.obs;
  Rx<bool> isDownloadComplet = false.obs;
  Rx<UploadStage> uploadStage = UploadStage.analyzingStorage.obs;

  // get uploadStage => _uploadStage.value;

  late File? file;
  late FilePickerResult? pickFile;
  late Uint8List? fileBytes;
  late Rx<TaskSnapshot> taskSnapshot;
  String pathInFirestore = '';
  late Function(String) externalGetUrl;

  startUpload() async {
    uploadStage.value = UploadStage.startingUpload;
    uploadStage.value = UploadStage.searchingFileLocally;

    bool selectedFile = await selectFileUpload();
    if (selectedFile) {
      uploadStage.value = UploadStage.foundLocallyFile;

      upload(pathInFirestore);
    } else {
      uploadStage.value = UploadStage.erroFetchFileLocally;
    }
  }

  Future<bool> selectFileUpload() async {
    restartingStateUploadAction();
    bool status = await selectFile();

    if (status) {
      return true;
    } else {
      restartingStateUploadAction();
      return false;
    }
  }

  restartingStateUploadAction() {
    fileName.value = '';
    uploadPercentage.value = 0;
    urlForDownload.value = '';
  }

  Future<bool> selectFile() async {
    pickFile = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (pickFile?.files.first == null) return false;
    _choiceEnviroment();
    return true;
  }

  void _choiceEnviroment() {
    if (GetPlatform.isWeb) {
      //It's web
      _fileInWeb();
    } else if (GetPlatform.isAndroid) {
      //it's Android
      _fileInAndroid();
    }
  }

  void _fileInWeb() {
    fileBytes = pickFile!.files.first.bytes;
    fileName.value = pickFile!.files.first.name;
  }

  void _fileInAndroid() async {
    final path = pickFile!.files.single.path!;

    file = File(path);
    fileBytes = file!.readAsBytesSync();
    fileName.value = basename(file!.path);
  }

  upload(String pathInFirestore) async {
    uploadStage.value = UploadStage.connectingWithStorage;

    UploadTask? uploadTask = uploadingBytes(pathInFirestore);
    if (uploadTask != null) {
      uploadStage.value = UploadStage.sendingFileToStorage;
    } else {
      uploadStage.value = UploadStage.errorSendingFileToStorage;
      return null;
    }
    Stream<TaskSnapshot> streamTaskSnapshot = uploadTask.snapshotEvents;
    streamTaskSnapshot.listen((event) {
      final progress = event.bytesTransferred / event.totalBytes;
      uploadPercentage.value = (progress * 100).toInt();
    });
    final snapshot = await uploadTask.whenComplete(() {
      uploadStage.value = UploadStage.shippingCompleted;
    });
    uploadStage.value = UploadStage.gettingRrl;
    urlForDownload.value = await snapshot.ref.getDownloadURL();
    uploadStage.value = UploadStage.uploadCompleted;
    isDownloadComplet.toggle();

    externalGetUrl(urlForDownload.value);
  }

  UploadTask? uploadingBytes(String pathInFirestore) {
    UploadTask? task;
    try {
      final ref = FirebaseStorage.instance.ref('$pathInFirestore/$fileName');
      task = ref.putData(fileBytes!);
    } on FirebaseException {
      return null;
    }
    return task;
  }

  checkFileInStorage(String urlStorage) {
    if (urlStorage.isEmpty) {
      uploadStage.value = UploadStage.notExistFileInStorage;
    } else {
      uploadStage.value = UploadStage.existFileInStorage;
    }
  }
}
