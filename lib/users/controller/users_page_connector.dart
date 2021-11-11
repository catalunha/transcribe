// import 'package:async_redux/async_redux.dart';
// import 'package:classfrase/user/controller/user_model.dart';
// import 'package:classfrase/users/controller/users_action.dart';
// import 'package:flutter/material.dart';

// import '../../app_state.dart';
// import '../users_page.dart';

// class UsersPageConnector extends StatelessWidget {
//   const UsersPageConnector({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StoreConnector<AppState, UsersPageVm>(
//       vm: () => UsersPageVmFactory(this),
//       onInit: (store) async {
//         await store.dispatch(StreamDocsUsersAction());
//         await store.dispatch(GetCountPhrasesUsersAction());
//       },
//       builder: (context, vm) => UsersPage(
//         usersList: vm.usersList,
//         countPhrases: vm.countPhrases,
//       ),
//     );
//   }
// }

// class UsersPageVmFactory extends VmFactory<AppState, UsersPageConnector> {
//   UsersPageVmFactory(widget) : super(widget);
//   @override
//   UsersPageVm fromStore() => UsersPageVm(
//         usersList: state.usersState.usersList!,
//         countPhrases: state.usersState.countPhrases ?? 0,
//       );
// }

// class UsersPageVm extends Vm {
//   final List<UserModel> usersList;
//   final int countPhrases;
//   UsersPageVm({
//     required this.usersList,
//     required this.countPhrases,
//   }) : super(equals: [
//           usersList,
//           countPhrases,
//         ]);
// }
