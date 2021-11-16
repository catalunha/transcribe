import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:transcribe/user/controller/user_model.dart';

class TeamModel {
  static const String collection = 'teams';

  final String id;
  final UserRef teacher;
  final String name;

  /// userMap{userId:UserRef}
  final Map<String, UserRef> userMap;
  final bool isArchived;
  final bool isDeleted;
  TeamModel({
    required this.id,
    required this.teacher,
    required this.name,
    required this.userMap,
    this.isArchived = false,
    this.isDeleted = false,
  });

  TeamModel copyWith({
    UserRef? teacher,
    String? name,
    Map<String, UserRef>? userMap,
    bool? isArchived,
    bool? isDeleted,
  }) {
    return TeamModel(
      id: id,
      teacher: teacher ?? this.teacher,
      name: name ?? this.name,
      userMap: userMap ?? this.userMap,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  TeamModel copy() {
    return TeamModel.fromMap(toMap());
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['teacher'] = teacher.toMap();
    data['name'] = name;
    data['isArchived'] = isArchived;
    data['userList'] = userMap.keys.toList();
    data["userMap"] = <String, dynamic>{};
    for (var item in userMap.entries) {
      data["userMap"][item.key] = item.value.toMap();
    }
    return data;
  }

  factory TeamModel.fromMap(Map<String, dynamic> map) {
    Map<String, UserRef>? _userMap = <String, UserRef>{};
    if (map["userMap"] != null && map["userMap"] is Map) {
      for (var item in map["userMap"].entries) {
        _userMap[item.key] = UserRef.fromMap(item.value);
      }
    }
    return TeamModel(
      id: map['id'],
      teacher: UserRef.fromMap(map['teacher']),
      name: map['name'],
      userMap: _userMap,
      isArchived: map['isArchived'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamModel.fromJson(String source) =>
      TeamModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TeamModel(teacher: $teacher, name: $name, userMap: $userMap)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeamModel &&
        other.id == id &&
        other.teacher == teacher &&
        other.name == name &&
        other.isArchived == isArchived &&
        other.isDeleted == isDeleted &&
        mapEquals(other.userMap, userMap);
  }

  @override
  int get hashCode {
    return teacher.hashCode ^
        id.hashCode ^
        name.hashCode ^
        isArchived.hashCode ^
        isDeleted.hashCode ^
        userMap.hashCode;
  }
}
