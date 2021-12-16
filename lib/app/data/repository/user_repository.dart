import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:transcribe/app/data/model/user_model.dart';

class UserRepository extends GetxService {
  final FirebaseFirestore _firebaseFirestoreInstance =
      FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getByUid(String uid) async {
    var querySnapshot = await _firebaseFirestoreInstance
        .collection(UserModel.collection)
        .where('uid', isEqualTo: uid)
        .get();
    var documentListMapIdData = querySnapshot.docs
        .map((queryDocumentSnapshot) =>
            {queryDocumentSnapshot.id: queryDocumentSnapshot.data()})
        .toList();
    if (documentListMapIdData.isEmpty) {
      return null;
    } else {
      Map<String, Map<String, dynamic>> documentMapIdData =
          documentListMapIdData.first;
      // String documentId = documentMapIdData.keys.first;
      Map<String, dynamic> documentData = documentMapIdData.values.first;

      return documentData;
    }
  }

  Future<Map<String, dynamic>> create(Map<String, dynamic> data) async {
    CollectionReference docRef =
        _firebaseFirestoreInstance.collection(UserModel.collection);
    String idNew = docRef.doc().id;
    data['id'] = idNew;
    await docRef.doc(idNew).set(data);
    return data;
  }

  Future<List<UserModel>> getAll() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestoreInstance
            .collection(UserModel.collection)
            .where('accessType', arrayContains: 'student')
            .where('isActive', isEqualTo: true)
            .get();
    List<UserModel> userModelList = <UserModel>[];
    userModelList = querySnapshot.docs
        .map(
          (queryDocumentSnapshot) => UserModel.fromMap(
            queryDocumentSnapshot.data(),
          ),
        )
        .toList();
    return userModelList;
  }
}
