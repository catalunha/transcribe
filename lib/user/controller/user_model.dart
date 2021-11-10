import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  static const String collection = 'users';
  final String id;
  final String uid;
  final String email;
  final String? photoURL;
  final String? displayName;
  final bool isActive;
  late List<String> accessType; // [teacher,student,admin]

  UserModel(
    this.id, {
    required this.email,
    required this.uid,
    this.displayName,
    this.photoURL,
    this.isActive = true,
    required this.accessType,
  });

  UserModel copyWith({
    String? displayName,
    String? email,
    String? uid,
    String? photoURL,
    bool? isActive,
    List<String>? accessType,
  }) {
    return UserModel(
      id,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      photoURL: photoURL ?? this.photoURL,
      isActive: isActive ?? this.isActive,
      accessType: accessType ?? this.accessType,
    );
  }

  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id,
      uid: map['uid'],
      email: map['email'],
      displayName: map['displayName'],
      photoURL: map['photoURL'],
      isActive: map['isActive'],
      accessType: map['accessType'].cast<String>(),
    );
  }

  factory UserModel.fromJson(String id, String source) =>
      UserModel.fromMap(id, json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      if (photoURL != null) 'photoURL': photoURL,
      if (displayName != null) 'displayName': displayName,
      'isActive': isActive,
      'accessType': accessType.cast<dynamic>(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'UserModel(displayName: $displayName, email: $email, photoURL: $photoURL, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        listEquals(other.accessType, accessType) &&
        other.isActive == isActive &&
        other.displayName == displayName &&
        other.email == email &&
        other.uid == uid &&
        other.photoURL == photoURL;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        displayName.hashCode ^
        isActive.hashCode ^
        accessType.hashCode ^
        email.hashCode ^
        uid.hashCode ^
        photoURL.hashCode;
  }
}

class UserRef {
  final String id;
  final String? photoURL;
  final String? displayName;
  UserRef({
    required this.id,
    this.photoURL,
    this.displayName,
  });

  UserRef copyWith({
    String? id,
    String? photoURL,
    String? displayName,
  }) {
    return UserRef(
      id: id ?? this.id,
      photoURL: photoURL ?? this.photoURL,
      displayName: displayName ?? this.displayName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'photoURL': photoURL,
      'displayName': displayName,
    };
  }

  factory UserRef.fromMap(Map<String, dynamic> map) {
    return UserRef(
      id: map['id'],
      photoURL: map['photoURL'],
      displayName: map['displayName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRef.fromJson(String source) =>
      UserRef.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserRef(id: $id, photoURL: $photoURL, displayName: $displayName)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserRef &&
        other.id == id &&
        other.photoURL == photoURL &&
        other.displayName == displayName;
  }

  @override
  int get hashCode => id.hashCode ^ photoURL.hashCode ^ displayName.hashCode;
}
