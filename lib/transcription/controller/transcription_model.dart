import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:transcribe/task/controller/task_model.dart';
import 'package:transcribe/user/controller/user_model.dart';

class TranscriptionModel {
  static const String collection = 'transcriptions';

  final String id;
  final UserRef student;
  final TaskModel task;
  final String? phraseWritten;
  final List<String>? phraseOrdered;
  final bool isSolved;
  final bool isArchived;
  final bool isDeleted;
  TranscriptionModel({
    required this.id,
    required this.student,
    required this.task,
    this.phraseWritten,
    this.phraseOrdered,
    this.isSolved = false,
    this.isArchived = false,
    this.isDeleted = false,
  });

  TranscriptionModel copyWith({
    String? id,
    UserRef? student,
    TaskModel? task,
    String? phraseWritten,
    List<String>? phraseOrdered,
    bool? isSolved,
    bool? isArchived,
    bool? isDeleted,
  }) {
    return TranscriptionModel(
      id: id ?? this.id,
      student: student ?? this.student,
      task: task ?? this.task,
      phraseWritten: phraseWritten ?? this.phraseWritten,
      phraseOrdered: phraseOrdered ?? this.phraseOrdered,
      isSolved: isSolved ?? this.isSolved,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  TranscriptionModel copy() {
    return TranscriptionModel.fromMap(toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'student': student.toMap(),
      'task': task.toMap(),
      'phraseWritten': phraseWritten ?? '',
      'phraseOrdered':
          phraseOrdered != null ? phraseOrdered!.cast<dynamic>() : [],
      'isSolved': isSolved,
      'isArchived': isArchived,
      'isDeleted': isDeleted,
    };
  }

  factory TranscriptionModel.fromMap(Map<String, dynamic> map) {
    return TranscriptionModel(
      id: map['id'],
      student: UserRef.fromMap(map['student']),
      task: TaskModel.fromMap(map['task']),
      phraseWritten: map['phraseWritten'],
      phraseOrdered: map['phraseOrdered'].cast<String>(),
      isSolved: map['isSolved'],
      isArchived: map['isArchived'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TranscriptionModel.fromJson(String source) =>
      TranscriptionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TranscriptionModel(id: $id, student: $student, task: $task, phraseWritten: $phraseWritten, phraseOrdered: $phraseOrdered, isSolved: $isSolved, isArchived: $isArchived, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TranscriptionModel &&
        other.id == id &&
        other.student == student &&
        other.task == task &&
        other.phraseWritten == phraseWritten &&
        listEquals(other.phraseOrdered, phraseOrdered) &&
        other.isSolved == isSolved &&
        other.isArchived == isArchived &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        student.hashCode ^
        task.hashCode ^
        phraseWritten.hashCode ^
        phraseOrdered.hashCode ^
        isSolved.hashCode ^
        isArchived.hashCode ^
        isDeleted.hashCode;
  }
}
