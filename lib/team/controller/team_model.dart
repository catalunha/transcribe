import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:transcribe/user/controller/user_model.dart';

class TeamModel {
  static const String collection = 'teams';

  final String id;
  final UserRef teacher;
  final String name;
  final Map<String, UserRef> userMap; //<userId,UserRef>
  final bool isArchived;
  final bool isDeleted;
  TeamModel(
    this.id, {
    required this.teacher,
    required this.name,
    // required this.userList,
    required this.userMap,
    this.isArchived = false,
    this.isDeleted = false,
  });

  TeamModel copyWith({
    UserRef? teacher,
    String? name,
    // List<String>? userList,
    Map<String, UserRef>? userMap,
    bool? isArchived,
    bool? isDeleted,
  }) {
    return TeamModel(
      id,
      teacher: teacher ?? this.teacher,
      name: name ?? this.name,
      // userList: userList ?? this.userList,
      userMap: userMap ?? this.userMap,
      isArchived: isArchived ?? this.isArchived,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['teacher'] = teacher.toMap();
    data['name'] = name;
    data['isArchived'] = isArchived;
    data['isDeleted'] = isDeleted;
    data['userList'] = userMap.keys.toList();
    data["userMap"] = <String, dynamic>{};
    for (var item in userMap.entries) {
      data["userMap"][item.key] = item.value.toMap();
    }
    return data;

    // return {
    //   'teacher': teacher.toMap(),
    //   'name': name,
    //   'userList': userMap.keys.toList(),
    //   'userMap': userMap.cast(<{}>)
    //   'isArchived': isArchived,
    //   'isDeleted': isDeleted,
    // };
  }

  factory TeamModel.fromMap(String id, Map<String, dynamic> map) {
    Map<String, UserRef>? _userMap = <String, UserRef>{};
    if (map["userMap"] != null && map["userMap"] is Map) {
      for (var item in map["userMap"].entries) {
        _userMap[item.key] = UserRef.fromMap(item.value);
      }
    }
    return TeamModel(
      id,
      teacher: UserRef.fromMap(map['teacher']),
      name: map['name'],
      userMap: _userMap,
      isArchived: map['isArchived'],
      isDeleted: map['isDeleted'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TeamModel.fromJson(String id, String source) =>
      TeamModel.fromMap(id, json.decode(source));

  @override
  String toString() {
    return 'TeamModel(teacher: $teacher, name: $name, userMap: $userMap)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeamModel &&
        other.teacher == teacher &&
        other.name == name &&
        other.isArchived == isArchived &&
        other.isDeleted == isDeleted &&
        // listEquals(other.userList, userList) &&
        mapEquals(other.userMap, userMap);
  }

  @override
  int get hashCode {
    return teacher.hashCode ^
        name.hashCode ^
        isArchived.hashCode ^
        isDeleted.hashCode ^
        // userList.hashCode ^
        userMap.hashCode;
  }
}
