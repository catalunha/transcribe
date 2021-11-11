import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:transcribe/user/controller/user_model.dart';

import '../../app_state.dart';
import 'team_model.dart';

class StreamDocsTeamAction extends ReduxAction<AppState> {
  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Query<Map<String, dynamic>> collRef;
    collRef = firebaseFirestore
        .collection(TeamModel.collection)
        .where('teacher.id', isEqualTo: state.userState.userCurrent!.id)
        .where('isArchived', isEqualTo: false)
        .where('isDeleted', isEqualTo: false);

    Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
        collRef.snapshots();

    Stream<List<TeamModel>> streamList = streamQuerySnapshot.map(
        (querySnapshot) => querySnapshot.docs
            .map((docSnapshot) =>
                TeamModel.fromMap(docSnapshot.id, docSnapshot.data()))
            .toList());
    streamList.listen((List<TeamModel> teamModelList) {
      dispatch(SetTeamListTeamAction(teamList: teamModelList));
    });

    return null;
  }
}

class SetTeamListTeamAction extends ReduxAction<AppState> {
  final List<TeamModel> teamList;

  SetTeamListTeamAction({required this.teamList});
  @override
  AppState reduce() {
    teamList.sort((a, b) => a.name.compareTo(b.name));

    return state.copyWith(
      teamState: state.teamState.copyWith(
        teamList: teamList,
      ),
    );
  }

  @override
  void after() {
    if (state.teamState.teamCurrent != null) {
      dispatch(SetTeamCurrentTeamAction(id: state.teamState.teamCurrent!.id));
    }
  }
}

class SetTeamCurrentTeamAction extends ReduxAction<AppState> {
  final String id;
  SetTeamCurrentTeamAction({
    required this.id,
  });
  @override
  AppState reduce() {
    TeamModel teamModel;
    if (id.isNotEmpty) {
      teamModel =
          state.teamState.teamList!.firstWhere((element) => element.id == id);
    } else {
      teamModel = TeamModel('',
          teacher: UserRef.fromMap({
            'id': state.userState.userCurrent!.id,
            'email': state.userState.userCurrent!.email,
            'photoURL': state.userState.userCurrent!.photoURL,
            'displayName': state.userState.userCurrent!.displayName
          }),
          name: '',
          // userList: <String, UserRef>{}.keys.toList(),
          userMap: <String, UserRef>{});
    }
    return state.copyWith(
      teamState: state.teamState.copyWith(
        teamCurrent: teamModel,
      ),
    );
  }
}

// class SetNulPhraseTeamAction extends ReduxAction<AppState> {
//   @override
//   AppState reduce() {
//     return state.copyWith(
//       teamState: state.teamState.copyWith(
//         teamPhraseCurrentSetNull: true,
//         teamPhraseListSetNull: true,
//       ),
//     );
//   }
// }

class AddDocTeamAction extends ReduxAction<AppState> {
  final TeamModel teamModel;

  AddDocTeamAction({required this.teamModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference docRef =
        firebaseFirestore.collection(TeamModel.collection);
    await docRef.add(teamModel.toMap());
    return null;
  }
}

class UpdateDocTeamAction extends ReduxAction<AppState> {
  final TeamModel teamModel;

  UpdateDocTeamAction({required this.teamModel});

  @override
  Future<AppState?> reduce() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DocumentReference docRef =
        firebaseFirestore.collection(TeamModel.collection).doc(teamModel.id);

    dispatch(SetTeamCurrentTeamAction(id: ''));
    if (teamModel.isDeleted) {
      await docRef.delete();
    } else {
      await docRef.update(teamModel.toMap());
    }

    return null;
  }
}

class AddOrDeleteUserTeamAction extends ReduxAction<AppState> {
  final bool addOrDelete;
  final String userId;

  AddOrDeleteUserTeamAction({required this.addOrDelete, required this.userId});
  @override
  AppState reduce() {
    UserRef userRef = state.usersState.userRefList!
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



// class GetDocsPhraseObservedAndSetNullTeamAction extends ReduxAction<AppState> {
//   final String teamId;

//   GetDocsPhraseObservedAndSetNullTeamAction({required this.teamId});
//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     Query<Map<String, dynamic>> collRef;
//     collRef = firebaseFirestore
//         .collection(PhraseModel.collection)
//         .where('team', isEqualTo: teamId);

//     var futureQuerySnapshot = await collRef.get();
//     var phraseIdList =
//         futureQuerySnapshot.docs.map((docSnapshot) => docSnapshot.id).toList();
//     for (var phraseId in phraseIdList) {
//       dispatch(SetNullTeamFieldPhraseTeamAction(phraseId: phraseId));
//     }
//     return null;
//   }
// }

// class SetNullTeamFieldPhraseTeamAction extends ReduxAction<AppState> {
//   final String phraseId;

//   SetNullTeamFieldPhraseTeamAction({required this.phraseId});

//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     DocumentReference docRef =
//         firebaseFirestore.collection(PhraseModel.collection).doc(phraseId);
//     await docRef.update({'team': null});

//     return null;
//   }
// }

// class StreamDocsPhraseTeamAction extends ReduxAction<AppState> {
//   @override
//   Future<AppState?> reduce() async {
//     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     Query<Map<String, dynamic>> collRef;
//     collRef = firebaseFirestore
//         .collection(PhraseModel.collection)
//         .where('team', isEqualTo: state.teamState.teamCurrent!.id)
//         .where('isDeleted', isEqualTo: false)
//         .where('isArchived', isEqualTo: false);

//     Stream<QuerySnapshot<Map<String, dynamic>>> streamQuerySnapshot =
//         collRef.snapshots();

//     Stream<List<PhraseModel>> streamList = streamQuerySnapshot.map(
//         (querySnapshot) => querySnapshot.docs
//             .map((docSnapshot) =>
//                 PhraseModel.fromMap(docSnapshot.id, docSnapshot.data()))
//             .toList());
//     streamList.listen((List<PhraseModel> phraseModelList) {
//       dispatch(SetTeamPhraseListTeamAction(teamPhraseList: phraseModelList));
//     });

//     return null;
//   }
// }

// class SetTeamPhraseListTeamAction extends ReduxAction<AppState> {
//   final List<PhraseModel> teamPhraseList;

//   SetTeamPhraseListTeamAction({required this.teamPhraseList});
//   @override
//   AppState reduce() {
//     teamPhraseList.sort((a, b) => a.phrase.compareTo(b.phrase));
//     return state.copyWith(
//       teamState: state.teamState.copyWith(
//         teamPhraseList: teamPhraseList,
//       ),
//     );
//   }

//   void after() {
//     if (state.teamState.teamPhraseCurrent != null) {
//       dispatch(SetTeamPhraseCurrentTeamAction(
//           id: state.teamState.teamPhraseCurrent!.id));
//     }
//   }
// }

// class SetTeamPhraseCurrentTeamAction extends ReduxAction<AppState> {
//   final String id;
//   SetTeamPhraseCurrentTeamAction({required this.id});
//   @override
//   AppState reduce() {
//     PhraseModel phraseModel;
//     phraseModel = state.teamState.teamPhraseList!
//         .firstWhere((element) => element.id == id);

//     return state.copyWith(
//       teamState: state.teamState.copyWith(
//         teamPhraseCurrent: phraseModel,
//       ),
//     );
//   }
// }
