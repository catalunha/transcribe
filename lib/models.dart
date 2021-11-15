// //User
// class UserModel {
//   late String id;
//   late String uid;
//   late String email;
//   late String? photoURL;
//   late String? displayName;
//   late bool isActive;
//   late List<String> accessType; // [teacher,student,admin]
// }

// class UserRef {
//   late String id;
//   late String email;
//   late String? photoURL;
//   late String? displayName;
// }

// //team
// class TeamModel {
//   late String id;
//   late UserRef teacher;
//   late String title;
//   late List<String> userList; //[userId]
//   late Map<String, UserRef> userMap; //<userId,UserRef>
// }

// //Phrase
// class PhraseModel {
//   late String id;
//   late UserRef teacher;
//   late String title;
//   late List<String> phraseList;
//   late String phraseAudio;
//   late bool isArchived;
//   late bool isDeleted;
//   late String? phraseImage;
//   late List<String>? phraseListImage;
// }

// //Task
// class TaskModel {
//   late String id;
//   late String title;
//   late TeamModel team;
//   late PhraseModel phrase;
//   late bool isWritten;
//   late bool? showPhraseImage;
//   late bool? showPhraseListImage;
//   late bool isArchived;
//   late bool isDeleted;
// }

// //Transcription
// class TranscriptionModel {
//   late String id;
//   late String student;
//   late TaskModel task;
//   late String phraseWritten;
//   late List<String> phraseOrdered;
//   late bool isSolved;
//   late bool isArchived;
//   late bool isDeleted;
// }
