import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:transcribe/team/controller/team_model.dart';
import 'package:transcribe/user/controller/user_model.dart';

import '../../app_state.dart';

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

class ReadDocsUserSearchUserAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firebaseFirestore
        .collection(UserModel.collection)
        .where('accessType', arrayContains: 'student')
        .where('isActive', isEqualTo: true)
        .get();
    IList<UserModel> userModelList = IList();
    userModelList = querySnapshot.docs
        .map(
          (queryDocumentSnapshot) => UserModel.fromMap(
            queryDocumentSnapshot.data(),
          ),
        )
        .toIList();
    dispatch(SetUserRefListSearchUserAction(userModelList: userModelList));
    return null;
  }
}

class SetUserRefListSearchUserAction extends ReduxAction<AppState> {
  final IList<UserModel> userModelList;

  SetUserRefListSearchUserAction({required this.userModelList});
  @override
  AppState reduce() {
    IList<UserRef> userRefList = IList();
    // for (var userModel in userModelList) {
    //   userRefList.add(
    //     UserRef(
    //         id: userModel.id,
    //         email: userModel.email,
    //         photoURL: userModel.photoURL,
    //         displayName: userModel.displayName),
    //   );
    // }
    userRefList = userModelList
        .map(
          (userModel) => UserRef(
              id: userModel.id,
              email: userModel.email,
              photoURL: userModel.photoURL,
              displayName: userModel.displayName),
        )
        .toIList();
    return state.copyWith(
      usersState: state.usersState.copyWith(
        userRefIList: userRefList,
      ),
    );
  }
}

class AddOrDeleteUserInTeamSearchUserAction extends ReduxAction<AppState> {
  final bool addOrDelete;
  final String userId;

  AddOrDeleteUserInTeamSearchUserAction(
      {required this.addOrDelete, required this.userId});
  @override
  AppState reduce() {
    UserRef userRef = state.usersState.userRefIList!
        .firstWhere((element) => element.id == userId);
    TeamModel teamModel = state.teamState.teamCurrent!;
    if (addOrDelete) {
      teamModel.userMap.addAll({userRef.id: userRef});
    } else {
      teamModel.userMap.remove(userRef.id);
    }

    return state.copyWith(
      teamState: state.teamState.copyWith(
        teamCurrent: teamModel,
      ),
    );
  }
}
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
