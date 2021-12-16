import 'dart:convert';

import 'package:transcribe/app/data/model/phrase_model.dart';
import 'package:transcribe/app/data/model/team_model.dart';

class TaskModel {
  static const String collection = 'task';

  final String id;
  String title;
  TeamModel? team;
  PhraseModel? phrase;
  bool isWritten;
  bool isShowPhraseImage;
  bool isShowPhraseListImage;
  bool isArchived;
  TaskModel({
    required this.id,
    this.title = '',
    this.team,
    this.phrase,
    this.isWritten = false,
    this.isShowPhraseImage = false,
    this.isShowPhraseListImage = false,
    this.isArchived = false,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    TeamModel? team,
    bool teamSetNull = false,
    PhraseModel? phrase,
    bool? isWritten,
    bool? isShowPhraseImage,
    bool? isShowPhraseListImage,
    bool? isArchived,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      team: teamSetNull ? null : team ?? this.team,
      phrase: phrase ?? this.phrase,
      isWritten: isWritten ?? this.isWritten,
      isShowPhraseImage: isShowPhraseImage ?? this.isShowPhraseImage,
      isShowPhraseListImage:
          isShowPhraseListImage ?? this.isShowPhraseListImage,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = title;
    data['team'] = team != null ? team!.toMap() : null;
    data['phrase'] = phrase!.toMap();
    data['isWritten'] = isWritten;
    data['isShowPhraseImage'] = isShowPhraseImage;
    data['isShowPhraseListImage'] = isShowPhraseListImage;
    data['isArchived'] = isArchived;
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
          other.isArchived == isArchived;

  @override
  int get hashCode {
    return title.hashCode ^
        id.hashCode ^
        team.hashCode ^
        phrase.hashCode ^
        isWritten.hashCode ^
        isShowPhraseImage.hashCode ^
        isShowPhraseListImage.hashCode ^
        isArchived.hashCode;
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
