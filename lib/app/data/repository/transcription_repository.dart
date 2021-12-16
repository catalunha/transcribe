import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/data/model/transcription_model.dart';
import 'package:transcribe/app/modules/user/user_controller.dart';

class TranscriptionRepository {
  final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;

  Stream<List<TranscriptionModel>> streamAll() {
    UserController userController = Get.find<UserController>();

    Query<Map<String, dynamic>> collRef;
    collRef = _firebaseFirestoreInstance
        .collection(TranscriptionModel.collection)
        .where('student.id', isEqualTo: userController.userModel.id)
        .where('isArchived', isEqualTo: false);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<TranscriptionModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map(
                (docSnapshot) => TranscriptionModel.fromMap(docSnapshot.data()))
            .toList());

    return streamList;
  }

  Stream<List<TranscriptionModel>> streamAllArchived() {
    UserController userController = Get.find<UserController>();

    Query<Map<String, dynamic>> collRef;
    collRef = _firebaseFirestoreInstance
        .collection(TranscriptionModel.collection)
        .where('student.id', isEqualTo: userController.userModel.id)
        .where('isArchived', isEqualTo: true);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<TranscriptionModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map(
                (docSnapshot) => TranscriptionModel.fromMap(docSnapshot.data()))
            .toList());

    return streamList;
  }

  Stream<List<TranscriptionModel>> streamAllTranscriptionListOfPeopleOnTask(
      String taskId) {
    Query<Map<String, dynamic>> collRef;
    collRef = _firebaseFirestoreInstance
        .collection(TranscriptionModel.collection)
        .where('task.id', isEqualTo: taskId)
        .where('isArchived', isEqualTo: false);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<TranscriptionModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map(
                (docSnapshot) => TranscriptionModel.fromMap(docSnapshot.data()))
            .toList());

    return streamList;
  }

  delete(id) {
    _firebaseFirestoreInstance
        .collection(TranscriptionModel.collection)
        .doc(id)
        .delete();
  }

  String newId() {
    String idNew = _firebaseFirestoreInstance
        .collection(TranscriptionModel.collection)
        .doc()
        .id;
    return idNew;
  }

  Future<void> set(TranscriptionModel model) async {
    try {
      CollectionReference docRef =
          _firebaseFirestoreInstance.collection(TranscriptionModel.collection);
      await docRef.doc(model.id).set(model.toMap());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    try {
      CollectionReference docRef =
          _firebaseFirestoreInstance.collection(TranscriptionModel.collection);
      await docRef.doc(id).update(data);
    } catch (e) {
      rethrow;
    }
  }
}
