import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:transcribe/app/data/model/user_model.dart';

class TeamModel {
  static const String collection = 'team';

  final String id;
  UserRef teacher;
  String name;

  /// students{userId:UserRef}
  Map<String, UserRef> students;
  TeamModel({
    required this.id,
    required this.teacher,
    required this.name,
    required this.students,
  });

  TeamModel copyWith({
    UserRef? teacher,
    String? name,
    Map<String, UserRef>? students,
  }) {
    return TeamModel(
      id: id,
      teacher: teacher ?? this.teacher,
      name: name ?? this.name,
      students: students ?? this.students,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['teacher'] = teacher.toMap();
    data['name'] = name;
    data["students"] = <String, dynamic>{};
    for (var item in students.entries) {
      data["students"][item.key] = item.value.toMap();
    }
    return data;
  }

  factory TeamModel.fromMap(Map<String, dynamic> map) {
    Map<String, UserRef>? _students = <String, UserRef>{};
    if (map["students"] != null && map["students"] is Map) {
      for (var item in map["students"].entries) {
        _students[item.key] = UserRef.fromMap(item.value);
      }
    }
    return TeamModel(
      id: map['id'],
      teacher: UserRef.fromMap(map['teacher']),
      name: map['name'],
      students: _students,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamModel.fromJson(String source) =>
      TeamModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TeamModel(teacher: $teacher, name: $name, students: $students)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeamModel &&
        other.id == id &&
        other.teacher == teacher &&
        other.name == name &&
        mapEquals(other.students, students);
  }

  @override
  int get hashCode {
    return teacher.hashCode ^ id.hashCode ^ name.hashCode ^ students.hashCode;
  }
}
