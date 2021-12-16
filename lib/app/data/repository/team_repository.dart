import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/data/model/team_model.dart';
import 'package:transcribe/app/modules/user/user_controller.dart';

class TeamRepository {
  final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;

  Stream<List<TeamModel>> streamAll() {
    UserController userController = Get.find<UserController>();

    Query<Map<String, dynamic>> collRef;
    collRef = _firebaseFirestoreInstance
        .collection(TeamModel.collection)
        .where('teacher.id', isEqualTo: userController.userModel.id);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<TeamModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) => TeamModel.fromMap(docSnapshot.data()))
            .toList());

    return streamList;
  }

  Future<List<TeamModel>> getAll() async {
    UserController userController = Get.find<UserController>();

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestoreInstance
            .collection(TeamModel.collection)
            .where('teacher.id', isEqualTo: userController.userModel.id)
            // .where('isArchived', isEqualTo: false)
            .get();
    List<TeamModel> listModel = <TeamModel>[];
    listModel = querySnapshot.docs
        .map(
          (queryDocumentSnapshot) => TeamModel.fromMap(
            queryDocumentSnapshot.data(),
          ),
        )
        .toList();
    return listModel;
  }

  delete(id) {
    _firebaseFirestoreInstance
        .collection(TeamModel.collection)
        .doc(id)
        .delete();
  }

  String newId() {
    String idNew =
        _firebaseFirestoreInstance.collection(TeamModel.collection).doc().id;
    return idNew;
  }

  Future<void> set(TeamModel teamModel) async {
    try {
      CollectionReference docRef =
          _firebaseFirestoreInstance.collection(TeamModel.collection);
      await docRef.doc(teamModel.id).set(teamModel.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
