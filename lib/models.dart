//User
class UserModel {
  late String uid;
  late String email;
  late String? photoURL;
  late String? displayName;
  late bool isActive;
  late bool accessType; // student,teacher,admin
}

class UserRef {
  late String id;
  late String? photoURL;
  late String? displayName;
}

//Phrase
class PhraseModel {
  late UserRef userRef;
  late String phrase;
  late List<String> phraseList;
  late String phraseAudio;
  late String? phraseImage;
  late List<String>? phraseListImage;
  late String group;
  late bool isArchived;
  late bool isDeleted;
  late bool showPhraseImage;
  late bool showPhraseListImage;
}

class PhraseRef {
  late String id;
  late List<String> phraseList;
}

//Transcription
class TranscriptionModel {
  late UserRef userRef;
  late UserRef teacherRef;
  late PhraseRef phraseRef;
  late String phraseWritten;
  late List<String> phraseOrdered;
}

//Task
class TaskModel {
  late UserRef teacherRef;
  late PhraseRef phraseRef;
  late List<UserRef> user;
}
