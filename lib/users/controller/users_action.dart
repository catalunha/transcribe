// import 'package:async_redux/async_redux.dart';
// import 'package:classfrase/observer/controller/observer_model.dart';
// import 'package:classfrase/phrase/controller/phrase_model.dart';
// import 'package:classfrase/user/controller/user_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../app_state.dart';

// class StreamDocsUsersAction extends ReduxAction<AppState> {
//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//     var streamDocSnapshot =
//         firebaseFirestore.collection(UserModel.collection).snapshots();
//     Stream<List<UserModel>> streamList = streamDocSnapshot.map(
//         (querySnapshot) => querySnapshot.docs
//             .map((docSnapshot) =>
//                 UserModel.fromMap(docSnapshot.id, docSnapshot.data()))
//             .toList());
//     streamList.listen((userModelList) {
//       dispatch(SetUsersListUsersAction(userModelList: userModelList));
//     });

//     return null;
//   }
// }

// class SetUsersListUsersAction extends ReduxAction<AppState> {
//   final List<UserModel> userModelList;

//   SetUsersListUsersAction({required this.userModelList});
//   @override
//   AppState reduce() {
//     return state.copyWith(
//       usersState: state.usersState.copyWith(
//         usersList: userModelList,
//       ),
//     );
//   }

//   void after() {
//     if (state.usersState.usersCurrent != null) {
//       dispatch(
//           SetUsersCurrentUsersAction(id: state.usersState.usersCurrent!.id));
//     }
//   }
// }

// class SetUsersCurrentUsersAction extends ReduxAction<AppState> {
//   final String id;
//   SetUsersCurrentUsersAction({
//     required this.id,
//   });
//   @override
//   AppState reduce() {
//     UserModel userModel =
//         state.usersState.usersList!.firstWhere((element) => element.id == id);

//     return state.copyWith(
//       usersState: state.usersState.copyWith(
//         usersCurrent: userModel,
//       ),
//     );
//   }
// }

// class GetCountPhrasesUsersAction extends ReduxAction<AppState> {
//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//     await firebaseFirestore
//         .collection(PhraseModel.collection)
//         .get()
//         .then((value) {
//       dispatch(SetCountPhrasesUsersAction(countPhrases: value.size));
//     });

//     return null;
//   }
// }

// class SetCountPhrasesUsersAction extends ReduxAction<AppState> {
//   final int countPhrases;

//   SetCountPhrasesUsersAction({required this.countPhrases});
//   @override
//   AppState reduce() {
//     return state.copyWith(
//       usersState: state.usersState.copyWith(
//         countPhrases: countPhrases,
//       ),
//     );
//   }
// }

// class DeletePhrasesDeletedUsersAction extends ReduxAction<AppState> {
//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//     await firebaseFirestore
//         .collection(PhraseModel.collection)
//         .where('isDeleted', isEqualTo: true)
//         .get()
//         .then((value) {
//       for (var docChange in value.docChanges) {
//         firebaseFirestore
//             .collection(PhraseModel.collection)
//             .doc(docChange.doc.id)
//             .delete();
//       }
//     });

//     return null;
//   }
// }

// class DeleteObserverDeletedUsersAction extends ReduxAction<AppState> {
//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//     await firebaseFirestore
//         .collection(ObserverModel.collection)
//         .where('isDeleted', isEqualTo: true)
//         .get()
//         .then((value) {
//       for (var docChange in value.docChanges) {
//         firebaseFirestore
//             .collection(ObserverModel.collection)
//             .doc(docChange.doc.id)
//             .delete();
//       }
//     });

//     return null;
//   }
// }
