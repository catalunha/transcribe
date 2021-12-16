import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/data/model/phrase_model.dart';
import 'package:transcribe/app/modules/user/user_controller.dart';

class PhraseRepository {
  final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;

  Stream<List<PhraseModel>> streamAll() {
    UserController userController = Get.find<UserController>();

    Query<Map<String, dynamic>> collRef;
    collRef = _firebaseFirestoreInstance
        .collection(PhraseModel.collection)
        .where('teacher.id', isEqualTo: userController.userModel.id);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<PhraseModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) => PhraseModel.fromMap(docSnapshot.data()))
            .toList());

    return streamList;
  }

  Future<List<PhraseModel>> getAll() async {
    UserController userController = Get.find<UserController>();

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestoreInstance
            .collection(PhraseModel.collection)
            .where('teacher.id', isEqualTo: userController.userModel.id)
            // .where('isArchived', isEqualTo: false)
            .get();
    List<PhraseModel> listModel = <PhraseModel>[];
    listModel = querySnapshot.docs
        .map(
          (queryDocumentSnapshot) => PhraseModel.fromMap(
            queryDocumentSnapshot.data(),
          ),
        )
        .toList();
    return listModel;
  }

  delete(id) {
    _firebaseFirestoreInstance
        .collection(PhraseModel.collection)
        .doc(id)
        .delete();
  }

  String newId() {
    String idNew =
        _firebaseFirestoreInstance.collection(PhraseModel.collection).doc().id;
    return idNew;
  }

  Future<void> set(PhraseModel model) async {
    try {
      CollectionReference docRef =
          _firebaseFirestoreInstance.collection(PhraseModel.collection);
      await docRef.doc(model.id).set(model.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
