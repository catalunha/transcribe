// //User
// class UserModel {
//   late String uid;
//   late String email;
//   late String? photoURL;
//   late String? displayName;
//   late bool isActive;
//   late List<String> accessType; // [teacher,student,admin]
// }

// class UserRef {
//   late String id;
//   late String? photoURL;
//   late String? displayName;
// }

// //team
// class TeamModel {
//   late UserRef teacher;
//   late String name;
//   late List<String> userList; //[userId]
//   late Map<String, UserRef> userMap; //<userId,UserRef>
// }

// //Phrase
// class PhraseModel {
//   late UserRef teacher;
//   late List<String> phraseList;
//   late String group;
//   late String phraseAudio;
//   late String? phraseImage;
//   late bool? showPhraseImage;
//   late List<String>? phraseListImage;
//   late bool? showPhraseListImage;
//   late bool isArchived;
//   late bool isDeleted;
// }

// //Task
// class TaskModel {
//   late String group;
//   late PhraseModel phrase;
//   late TeamModel team;
//   late Map<String, Transcription>? transcriptionMap; //<userId,Transcription
//   late bool isArchivedByTeacher;
//   late bool isArchivedByStudent;
//   late bool isDeleted;
// }

// class Transcription {
//   late String phraseWritten;
//   late List<String> phraseOrdered;
// }
