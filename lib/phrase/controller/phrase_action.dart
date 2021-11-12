import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:transcribe/user/controller/user_model.dart';

import '../../app_state.dart';
import 'phrase_model.dart';

class StreamDocsPhraseAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(PhraseModel.collection)
        .where('teacher.id', isEqualTo: state.userState.userCurrent!.id)
        .where('isArchived', isEqualTo: false);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<PhraseModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) => PhraseModel.fromMap(docSnapshot.data()))
            .toList());
    streamList.listen((List<PhraseModel> phraseModelList) {
      dispatch(SetPhraseListPhraseAction(phraseList: phraseModelList));
    });

    return null;
  }
}

class SetPhraseListPhraseAction extends ReduxAction<AppState> {
  final List<PhraseModel> phraseList;

  SetPhraseListPhraseAction({required this.phraseList});
  @override
  AppState reduce() {
    int amount = 0;
    phraseList.sort((a, b) => a.group.compareTo(b.group));
    return state.copyWith(
      phraseState: state.phraseState.copyWith(
        phraseList: phraseList,
      ),
    );
  }

  @override
  void after() {
    if (state.phraseState.phraseCurrent != null) {
      dispatch(SetPhraseCurrentPhraseAction(
          id: state.phraseState.phraseCurrent!.id));
    }
  }
}

class SetPhraseCurrentPhraseAction extends ReduxAction<AppState> {
  final String id;
  SetPhraseCurrentPhraseAction({
    required this.id,
  });
  @override
  AppState reduce() {
    PhraseModel phraseModel;
    if (id.isNotEmpty) {
      phraseModel = state.phraseState.phraseList!
          .firstWhere((element) => element.id == id);
    } else {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      CollectionReference docRef =
          firebaseFirestore.collection(PhraseModel.collection);
      String idNew = docRef.doc().id;
      // String idNew = '';
      phraseModel = PhraseModel(
        id: idNew,
        teacher: UserRef.fromMap({
          'id': state.userState.userCurrent!.id,
          'email': state.userState.userCurrent!.email,
          'photoURL': state.userState.userCurrent!.photoURL,
          'displayName': state.userState.userCurrent!.displayName
        }),
        group: '',
        phraseList: [],
        phraseAudio: '',
      );
    }
    return state.copyWith(
      phraseState: state.phraseState.copyWith(
        phraseCurrent: phraseModel,
      ),
    );
  }
}

class CreateDocPhraseAction extends ReduxAction<AppState> {
  final PhraseModel phraseModel;

  CreateDocPhraseAction({required this.phraseModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference docRef =
        firebaseFirestore.collection(PhraseModel.collection);
    // PhraseModel phraseModelNew = phraseModel.copyWith(
    //     phraseList: PhraseModel.setPhraseList(phraseModel.phrase));
    await docRef.doc(phraseModel.id).set(phraseModel.toMap());
    // await docRef.add(phraseModel.toMap());
    return null;
  }
}

class UpdateDocPhraseAction extends ReduxAction<AppState> {
  final PhraseModel phraseModel;

  UpdateDocPhraseAction({required this.phraseModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef = firebaseFirestore
        .collection(PhraseModel.collection)
        .doc(phraseModel.id);
    PhraseModel phraseModelNew = phraseModel.copyWith();
    PhraseModel phraseModelOld = state.phraseState.phraseCurrent!;
    if (listEquals(phraseModelNew.phraseList, phraseModelOld.phraseList)) {
      phraseModelNew = phraseModel.copyWith(
        phraseImage: '',
        phraseListImage: [],
      );
    }
    // dispatch(SetPhraseCurrentPhraseAction(id: ''));
    if (phraseModelNew.isDeleted) {
      await docRef.delete();
    } else {
      await docRef.update(phraseModelNew.toMap()).then((value) {
        return state.copyWith(
          phraseState: state.phraseState.copyWith(
            phraseCurrentSetNull: true,
          ),
        );
      });
    }

    // return null;
  }
}



// class ReadDocsPhraseAction extends ReduxAction<AppState> {
//   final bool isArchived;

//   ReadDocsPhraseAction({required this.isArchived});
//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
//         .collection(PhraseModel.collection)
//         .where('userRef.id', isEqualTo: state.userState.userCurrent!.id)
//         .where('isDeleted', isEqualTo: false)
//         .where('isArchived', isEqualTo: isArchived)
//         .get();
//     List<PhraseModel> phraseModelList = [];
//     phraseModelList = querySnapshot.docs
//         .map(
//           (queryDocumentSnapshot) => PhraseModel.fromMap(
//             queryDocumentSnapshot.id,
//             queryDocumentSnapshot.data(),
//           ),
//         )
//         .toList();
//     dispatch(SetPhraseArchivedListPhraseAction(phraseList: phraseModelList));
//     return null;
//   }
// }
// class SetPhraseArchivedListPhraseAction extends ReduxAction<AppState> {
//   final List<PhraseModel> phraseList;

//   SetPhraseArchivedListPhraseAction({required this.phraseList});
//   @override
//   AppState reduce() {
//     return state.copyWith(
//       phraseState: state.phraseState.copyWith(
//         phraseArchivedList: phraseList,
//       ),
//     );
//   }
// }



// class UnArchivePhraseAction extends ReduxAction<AppState> {
//   final String phraseId;

//   UnArchivePhraseAction({required this.phraseId});

//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     DocumentReference docRef =
//         firebaseFirestore.collection(PhraseModel.collection).doc(phraseId);

//     await docRef.update({'isArchived': false});

//     return null;
//   }
// }
