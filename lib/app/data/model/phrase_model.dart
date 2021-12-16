import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:transcribe/app/data/model/user_model.dart';

class PhraseModel {
  static const String collection = 'phrase';
  final String id;

  UserRef teacher;
  String group;
  List<String> phraseList;
  String phraseAudio;

  String? phraseImage;
  List<String>? phraseListImage;
  PhraseModel({
    required this.id,
    required this.teacher,
    required this.group,
    required this.phraseList,
    required this.phraseAudio,
    this.phraseImage,
    this.phraseListImage,
  });

  PhraseModel copyWith({
    String? id,
    UserRef? teacher,
    String? group,
    List<String>? phraseList,
    String? phraseAudio,
    bool? isArchived,
    String? phraseImage,
    List<String>? phraseListImage,
  }) {
    return PhraseModel(
      id: id ?? this.id,
      teacher: teacher ?? this.teacher,
      group: group ?? this.group,
      phraseList: phraseList ?? this.phraseList,
      phraseAudio: phraseAudio ?? this.phraseAudio,
      phraseImage: phraseImage ?? this.phraseImage,
      phraseListImage: phraseListImage ?? this.phraseListImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'teacher': teacher.toMap(),
      'group': group,
      'phraseList': phraseList.cast<String>(),
      'phraseAudio': phraseAudio,
      if (phraseImage != null) 'phraseImage': phraseImage,
      if (phraseListImage != null)
        'phraseListImage': phraseListImage!.cast<String>(),
    };
  }

  factory PhraseModel.fromMap(Map<String, dynamic> map) {
    return PhraseModel(
      id: map['id'],
      teacher: UserRef.fromMap(map['teacher']),
      group: map['group'],
      phraseList: List<String>.from(map['phraseList']),
      phraseAudio: map['phraseAudio'],
      phraseImage: map['phraseImage'],
      phraseListImage: map['phraseListImage']?.cast<String>(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PhraseModel.fromJson(String source) =>
      PhraseModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PhraseModel(teacher: $teacher, group: $group, phraseList: $phraseList, phraseAudio: $phraseAudio, phraseImage: $phraseImage,  phraseListImage: $phraseListImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhraseModel &&
        other.id == id &&
        other.teacher == teacher &&
        other.group == group &&
        listEquals(other.phraseList, phraseList) &&
        other.phraseAudio == phraseAudio &&
        other.phraseImage == phraseImage &&
        listEquals(other.phraseListImage, phraseListImage);
  }

  @override
  int get hashCode {
    return teacher.hashCode ^
        id.hashCode ^
        group.hashCode ^
        phraseList.hashCode ^
        phraseAudio.hashCode ^
        phraseImage.hashCode ^
        phraseListImage.hashCode;
  }
}
