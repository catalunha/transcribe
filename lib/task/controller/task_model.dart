import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:transcribe/phrase/controller/phrase_model.dart';
import 'package:transcribe/team/controller/team_model.dart';

class TaskModel {
  final String group;
  final TeamModel team;
  final PhraseModel phrase;
  final bool? isWritten;
  final bool? isShowPhraseImage;
  final bool? isShowPhraseListImage;
  final Map<String, Transcription>? transcriptionMap; //<userId,Transcription
  final bool isArchivedByTeacher;
  final bool isArchivedByStudent;
  final bool isDeleted;
  TaskModel({
    required this.group,
    required this.team,
    required this.phrase,
    this.isWritten,
    this.isShowPhraseImage,
    this.isShowPhraseListImage,
    this.transcriptionMap,
    this.isArchivedByTeacher = false,
    this.isArchivedByStudent = false,
    this.isDeleted = false,
  });

  TaskModel copyWith({
    String? group,
    TeamModel? team,
    PhraseModel? phrase,
    bool? isWritten,
    bool? isShowPhraseImage,
    bool? isShowPhraseListImage,
    Map<String, Transcription>? transcriptionMap,
    bool? isArchivedByTeacher,
    bool? isArchivedByStudent,
    bool? isDeleted,
  }) {
    return TaskModel(
      group: group ?? this.group,
      team: team ?? this.team,
      phrase: phrase ?? this.phrase,
      isWritten: isWritten ?? this.isWritten,
      isShowPhraseImage: isShowPhraseImage ?? this.isShowPhraseImage,
      isShowPhraseListImage:
          isShowPhraseListImage ?? this.isShowPhraseListImage,
      transcriptionMap: transcriptionMap ?? this.transcriptionMap,
      isArchivedByTeacher: isArchivedByTeacher ?? this.isArchivedByTeacher,
      isArchivedByStudent: isArchivedByStudent ?? this.isArchivedByStudent,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['group'] = group;
    data['team'] = team.toMap();
    data['phrase'] = phrase.toMap();
    if (isWritten != null) data['isWritten'] = isWritten;
    if (isShowPhraseImage != null)
      data['isShowPhraseImage'] = isShowPhraseImage;
    if (isShowPhraseListImage != null)
      data['isShowPhraseListImage'] = isShowPhraseListImage;
    data['transcriptionMap'] = transcriptionMap;
    if (transcriptionMap != null) {
      data["transcriptionMap"] = <String, dynamic>{};
      for (var item in transcriptionMap!.entries) {
        data["transcriptionMap"][item.key] = item.value.toMap();
      }
    }
    data['isArchivedByTeacher'] = isArchivedByTeacher;
    data['isArchivedByStudent'] = isArchivedByStudent;
    data['isDeleted'] = isDeleted;
    return data;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    Map<String, Transcription>? _transcriptionMap = <String, Transcription>{};
    if (map["transcriptionMap"] != null && map["transcriptionMap"] is Map) {
      for (var item in map["transcriptionMap"].entries) {
        _transcriptionMap[item.key] = Transcription.fromMap(item.value);
      }
    }
    return TaskModel(
      group: map['group'],
      team: TeamModel.fromMap(map['team']),
      phrase: PhraseModel.fromMap(map['phrase']),
      isWritten: map['isWritten'] ?? false,
      isShowPhraseImage: map['isShowPhraseImage'] ?? false,
      isShowPhraseListImage: map['isShowPhraseListImage'] ?? false,
      transcriptionMap: _transcriptionMap,
      isArchivedByTeacher: map['isArchivedByTeacher'],
      isArchivedByStudent: map['isArchivedByStudent'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel(group: $group, team: $team, phrase: $phrase, isWritten: $isWritten, isShowPhraseImage: $isShowPhraseImage, isShowPhraseListImage: $isShowPhraseListImage, transcriptionMap: $transcriptionMap, isArchivedByTeacher: $isArchivedByTeacher, isArchivedByStudent: $isArchivedByStudent, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.group == group &&
        other.team == team &&
        other.phrase == phrase &&
        other.isWritten == isWritten &&
        other.isShowPhraseImage == isShowPhraseImage &&
        other.isShowPhraseListImage == isShowPhraseListImage &&
        mapEquals(other.transcriptionMap, transcriptionMap) &&
        other.isArchivedByTeacher == isArchivedByTeacher &&
        other.isArchivedByStudent == isArchivedByStudent &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return group.hashCode ^
        team.hashCode ^
        phrase.hashCode ^
        isWritten.hashCode ^
        isShowPhraseImage.hashCode ^
        isShowPhraseListImage.hashCode ^
        transcriptionMap.hashCode ^
        isArchivedByTeacher.hashCode ^
        isArchivedByStudent.hashCode ^
        isDeleted.hashCode;
  }
}

class Transcription {
  final String phraseWritten;
  final List<String> phraseOrdered;
  Transcription({
    required this.phraseWritten,
    required this.phraseOrdered,
  });

  Transcription copyWith({
    String? phraseWritten,
    List<String>? phraseOrdered,
  }) {
    return Transcription(
      phraseWritten: phraseWritten ?? this.phraseWritten,
      phraseOrdered: phraseOrdered ?? this.phraseOrdered,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phraseWritten': phraseWritten,
      'phraseOrdered': phraseOrdered,
    };
  }

  factory Transcription.fromMap(Map<String, dynamic> map) {
    return Transcription(
      phraseWritten: map['phraseWritten'],
      phraseOrdered: List<String>.from(map['phraseOrdered']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transcription.fromJson(String source) =>
      Transcription.fromMap(json.decode(source));

  @override
  String toString() =>
      'Transcription(phraseWritten: $phraseWritten, phraseOrdered: $phraseOrdered)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Transcription &&
        other.phraseWritten == phraseWritten &&
        listEquals(other.phraseOrdered, phraseOrdered);
  }

  @override
  int get hashCode => phraseWritten.hashCode ^ phraseOrdered.hashCode;
}
