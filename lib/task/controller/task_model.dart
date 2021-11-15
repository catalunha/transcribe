import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:transcribe/phrase/controller/phrase_model.dart';
import 'package:transcribe/team/controller/team_model.dart';

class TaskModel {
  static const String collection = 'tasks';

  final String id;
  final String title;
  final TeamModel? team;
  final PhraseModel? phrase;
  final bool isWritten;
  final bool isShowPhraseImage;
  final bool isShowPhraseListImage;
  final bool isArchived;
  final bool isDeleted;
  const TaskModel({
    required this.id,
    required this.title,
    this.team,
    this.phrase,
    this.isWritten = false,
    this.isShowPhraseImage = false,
    this.isShowPhraseListImage = false,
    this.isArchived = false,
    this.isDeleted = false,
  });

  TaskModel copyWith({
    String? title,
    TeamModel? team,
    bool teamSetNull = false,
    PhraseModel? phrase,
    bool? isWritten,
    bool? isShowPhraseImage,
    bool? isShowPhraseListImage,
    bool? isArchived,
    bool? isDeleted,
  }) {
    return TaskModel(
      id: id,
      title: title ?? this.title,
      team: teamSetNull ? null : team ?? this.team,
      phrase: phrase ?? this.phrase,
      isWritten: isWritten ?? this.isWritten,
      isShowPhraseImage: isShowPhraseImage ?? this.isShowPhraseImage,
      isShowPhraseListImage:
          isShowPhraseListImage ?? this.isShowPhraseListImage,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  TaskModel copy() {
    return TaskModel.fromMap(toMap());
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = id;
    data['name'] = title;
    data['team'] = team != null ? team!.toMap() : null;
    data['phrase'] = phrase!.toMap();
    data['isWritten'] = isWritten;
    data['isShowPhraseImage'] = isShowPhraseImage;
    data['isShowPhraseListImage'] = isShowPhraseListImage;
    data['isArchived'] = isArchived;
    data['isDeleted'] = isDeleted;
    return data;
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['name'],
      team: map['team'] != null ? TeamModel.fromMap(map['team']) : null,
      phrase: PhraseModel.fromMap(map['phrase']),
      isWritten: map['isWritten'],
      isShowPhraseImage: map['isShowPhraseImage'],
      isShowPhraseListImage: map['isShowPhraseListImage'],
      isArchived: map['isArchived'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel( hashCode:$hashCode, id:$id)';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModel &&
          runtimeType == other.runtimeType &&
          other.id == id &&
          other.title == title &&
          other.team == team &&
          other.phrase == phrase &&
          other.isWritten == isWritten &&
          other.isShowPhraseImage == isShowPhraseImage &&
          other.isShowPhraseListImage == isShowPhraseListImage &&
          other.isArchived == isArchived &&
          other.isDeleted == isDeleted;

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        team.hashCode ^
        phrase.hashCode ^
        isWritten.hashCode ^
        isShowPhraseImage.hashCode ^
        isShowPhraseListImage.hashCode ^
        isArchived.hashCode ^
        isDeleted.hashCode;
  }
}

class TaskRef {
  final String id;
  final String title;
  TaskRef({
    required this.id,
    required this.title,
  });

  TaskRef copyWith({
    String? id,
    String? title,
  }) {
    return TaskRef(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory TaskRef.fromMap(Map<String, dynamic> map) {
    return TaskRef(
      id: map['id'],
      title: map['title'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskRef.fromJson(String source) =>
      TaskRef.fromMap(json.decode(source));

  @override
  String toString() => 'TaskRef(id: $id, title: $title)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskRef && other.id == id && other.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
