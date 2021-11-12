import 'package:flutter/material.dart';
import 'package:async_redux/async_redux.dart';

import '../../app_state.dart';
import '../input_file.dart';
import 'upload_action.dart';

class InputFileConnector extends StatelessWidget {
  final String label;
  final bool requiredField;
  const InputFileConnector(
      {Key? key, required this.label, this.requiredField = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, InputFileViewModel>(
      vm: () => InputFileFactory(this),
      builder: (context, vm) => InputFile(
        label: label,
        selectLocalFile: vm.selectLocalFile,
        selectedLocalFileName: vm.selectedLocalFileName,
        uploadingFile: vm.uploadingFile,
        percentageOfUpload: vm.percentageOfUpload,
        urlForDownload: vm.urlForDownload,
        requiredField: vm.requiredField,
      ),
    );
  }
}

class InputFileFactory extends VmFactory<AppState, InputFileConnector> {
  InputFileFactory(widget) : super(widget);
  @override
  InputFileViewModel fromStore() => InputFileViewModel(
        selectLocalFile: () {
          dispatch(SelectFileUploadAction());
        },
        selectedLocalFileName: state.uploadState.fileName ?? '',
        uploadingFile: () async {
          await dispatch(UploadingFileUploadAction(
              pathInFirestore:
                  '${state.userState.userCurrent!.id}/${state.phraseState.phraseCurrent!.id}'));
        },
        percentageOfUpload: state.uploadState.uploadPercentage ?? 0.0,
        urlForDownload: state.uploadState.urlForDownload ?? '',
        requiredField: widget!.requiredField,
      );
}

class InputFileViewModel extends Vm {
  final VoidCallback selectLocalFile;
  final String selectedLocalFileName;
  final VoidCallback uploadingFile;
  final double percentageOfUpload;
  final String urlForDownload;
  final bool requiredField;
  InputFileViewModel({
    required this.selectLocalFile,
    required this.selectedLocalFileName,
    required this.uploadingFile,
    required this.percentageOfUpload,
    required this.urlForDownload,
    required this.requiredField,
  }) : super(
          equals: [
            selectedLocalFileName,
            percentageOfUpload,
            urlForDownload,
            requiredField,
          ],
        );
}
