import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:async_redux/async_redux.dart';
import 'package:file_picker/file_picker.dart';

import '../../app_state.dart';
import 'upload_state.dart';

class RestartingStateUploadAction extends ReduxAction<AppState> {
  RestartingStateUploadAction();
  @override
  AppState reduce() {
    return state.copyWith(uploadState: UploadState.initialState());
  }
}

class SetUrlForDownloadUploadAction extends ReduxAction<AppState> {
  final String url;
  SetUrlForDownloadUploadAction({required this.url});
  @override
  AppState reduce() {
    return state.copyWith(
        uploadState: state.uploadState.copyWith(urlForDownload: url));
  }
}

class SelectFileUploadAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    dispatch(RestartingStateUploadAction());
    UploadForFirebase uploadFirebase = UploadForFirebase();
    bool status = await uploadFirebase.selectFile();

    if (status) {
      return state.copyWith(
        uploadState: state.uploadState.copyWith(
          fileName: uploadFirebase.fileName,
          fileBytes: uploadFirebase.fileBytes,
        ),
      );
    } else {
      return state.copyWith(uploadState: UploadState.initialState());
    }
  }
}

class UploadingFileUploadAction extends ReduxAction<AppState> {
  final String pathInFirestore;

  UploadingFileUploadAction({required this.pathInFirestore});
  @override
  Future<AppState> reduce() async {
    UploadForFirebase uploadForFirebase = UploadForFirebase();
    String? file = state.uploadState.fileName;
    if (file != null) {
      UploadTask? task = uploadForFirebase.uploadingBytes(pathInFirestore,
          state.uploadState.fileName!, state.uploadState.fileBytes!);

      return state.copyWith(
          uploadState: state.uploadState.copyWith(uploadTask: task));
    } else {
      return state.copyWith(uploadState: UploadState.initialState());
    }
  }

  @override
  void after() => dispatch(StreamUploadTask());
}

class UpdateUploadPorcentageUploadAction extends ReduxAction<AppState> {
  final double value;

  UpdateUploadPorcentageUploadAction({required this.value});
  @override
  AppState reduce() {
    return state.copyWith(
      uploadState: state.uploadState.copyWith(
        uploadPercentage: value,
      ),
    );
  }
}

class UpdateUrlForDownloadUploadAction extends ReduxAction<AppState> {
  UpdateUrlForDownloadUploadAction();
  @override
  Future<AppState?> reduce() async {
    if (state.uploadState.uploadTask != null) {
      UploadTask task = state.uploadState.uploadTask!;
      final snapshot = await task.whenComplete(() {});
      String url = await snapshot.ref.getDownloadURL();
      return state.copyWith(
        uploadState: state.uploadState.copyWith(
          urlForDownload: url,
        ),
      );
    } else {
      return null;
    }
  }
}

class StreamUploadTask extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    if (state.uploadState.uploadTask != null) {
      UploadTask uploadTask = state.uploadState.uploadTask!;
      Stream<TaskSnapshot> streamTaskSnapshot = uploadTask.snapshotEvents;
      streamTaskSnapshot.listen((TaskSnapshot event) {
        final progress = event.bytesTransferred / event.totalBytes;
        final percentage = (progress * 100);
        // print(percentage);
        dispatch(UpdateUploadPorcentageUploadAction(value: percentage));
      });

      return null;
    } else {
      return null;
    }
  }

  @override
  void after() => dispatch(UpdateUrlForDownloadUploadAction());
}

class UploadForFirebase {
  File? file;
  String? fileName;
  Uint8List? fileBytes;
  late final FilePickerResult? pickFile;
  Future<bool> selectFile() async {
    pickFile = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (pickFile?.files.first == null) return false;
    _choiceEnviroment();
    // print('$fileName');
    return true;
  }

  void _choiceEnviroment() {
    if (kIsWeb) {
      //It's web
      _fileInWeb();
    } else if (Platform.isAndroid) {
      //it's Android
      _fileInAndroid();
    }
  }

  void _fileInWeb() {
    fileBytes = pickFile!.files.first.bytes;
    fileName = pickFile!.files.first.name;
    // print('$fileName');
  }

  void _fileInAndroid() async {
    final path = pickFile!.files.single.path!;

    file = File(path);
    fileBytes = file!.readAsBytesSync();
    fileName = basename(file!.path);
    // print('$fileName');
  }

  UploadTask? uploadingFile(File file, String pathInFirestore) {
    final fileName = basename(file.path);
    final destination = '$pathInFirestore/$fileName';
    UploadTask task;
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      task = ref.putFile(file);
    } on FirebaseException catch (e) {
      print('--> uploadingFile error $e');
      return null;
    }
    // if (task == null) return null;
    return task;
  }

  UploadTask? uploadingBytes(
      String pathInFirestore, String fileName, Uint8List fileBytes) {
    UploadTask? task;
    try {
      final ref = FirebaseStorage.instance.ref('$pathInFirestore/$fileName');
      task = ref.putData(fileBytes);
    } on FirebaseException catch (e) {
      print('--> uploadingBytes error $e');
      return null;
    }
    return task;
  }
}
