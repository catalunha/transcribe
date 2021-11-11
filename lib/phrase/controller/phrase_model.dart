import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:transcribe/user/controller/user_model.dart';

class PhraseModel {
  static const String collection = 'phrase';
  final String id;

  final UserRef teacher;
  final String group;
  final List<String> phraseList;
  final String phraseAudio;

  final bool isArchived;
  final bool isDeleted;

  final String? phraseImage;
  final bool? showPhraseImage;
  final List<String>? phraseListImage;
  final bool? showPhraseListImage;
  PhraseModel(
    this.id, {
    required this.teacher,
    required this.group,
    required this.phraseList,
    required this.phraseAudio,
    this.isArchived = false,
    this.isDeleted = false,
    this.phraseImage,
    this.showPhraseImage,
    this.phraseListImage,
    this.showPhraseListImage,
  });

  PhraseModel copyWith({
    UserRef? teacher,
    String? group,
    List<String>? phraseList,
    String? phraseAudio,
    bool? isArchived,
    bool? isDeleted,
    String? phraseImage,
    List<String>? phraseListImage,
    bool? showPhraseImage,
    bool? showPhraseListImage,
  }) {
    return PhraseModel(
      id,
      teacher: teacher ?? this.teacher,
      group: group ?? this.group,
      phraseList: phraseList ?? this.phraseList,
      phraseAudio: phraseAudio ?? this.phraseAudio,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
      phraseImage: phraseImage ?? this.phraseImage,
      showPhraseImage: showPhraseImage ?? this.showPhraseImage,
      phraseListImage: phraseListImage ?? this.phraseListImage,
      showPhraseListImage: showPhraseListImage ?? this.showPhraseListImage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teacher': teacher.toMap(),
      'group': group,
      'phraseList': phraseList.cast<String>(),
      'phraseAudio': phraseAudio,
      'isArchived': isArchived,
      'isDeleted': isDeleted,
      if (phraseImage != null) 'phraseImage': phraseImage,
      if (showPhraseImage != null) 'showPhraseImage': showPhraseImage,
      if (phraseListImage != null)
        'phraseListImage': phraseListImage!.cast<String>(),
      if (showPhraseListImage != null)
        'showPhraseListImage': showPhraseListImage,
    };
  }

  factory PhraseModel.fromMap(String id, Map<String, dynamic> map) {
    return PhraseModel(
      id,
      teacher: UserRef.fromMap(map['teacher']),
      group: map['group'],
      phraseList: List<String>.from(map['phraseList']),
      phraseAudio: map['phraseAudio'],
      isArchived: map['isArchived'],
      isDeleted: map['isDeleted'],
      phraseImage: map['phraseImage'],
      showPhraseImage: map['showPhraseImage'],
      phraseListImage: map['phraseListImage'] != null
          ? map['phraseListImage'].cast<String>()
          : null,
      showPhraseListImage: map['showPhraseListImage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PhraseModel.fromJson(String id, String source) =>
      PhraseModel.fromMap(id, json.decode(source));

  @override
  String toString() {
    return 'PhraseModel(teacher: $teacher, group: $group, phraseList: $phraseList, phraseAudio: $phraseAudio, isArchived: $isArchived, isDeleted: $isDeleted, phraseImage: $phraseImage, showPhraseImage: $showPhraseImage, phraseListImage: $phraseListImage, showPhraseListImage: $showPhraseListImage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhraseModel &&
        other.teacher == teacher &&
        other.group == group &&
        listEquals(other.phraseList, phraseList) &&
        other.phraseAudio == phraseAudio &&
        other.isArchived == isArchived &&
        other.isDeleted == isDeleted &&
        other.phraseImage == phraseImage &&
        other.showPhraseImage == showPhraseImage &&
        listEquals(other.phraseListImage, phraseListImage) &&
        other.showPhraseListImage == showPhraseListImage;
  }

  @override
  int get hashCode {
    return teacher.hashCode ^
        group.hashCode ^
        phraseList.hashCode ^
        phraseAudio.hashCode ^
        isArchived.hashCode ^
        isDeleted.hashCode ^
        phraseImage.hashCode ^
        showPhraseImage.hashCode ^
        phraseListImage.hashCode ^
        showPhraseListImage.hashCode;
  }
}
