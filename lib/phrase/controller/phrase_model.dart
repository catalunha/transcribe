import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:transcribe/user/controller/user_model.dart';

class PhraseModel {
  static const String collection = 'phrases';

  final String id;
  final UserRef userRef;
  final String phrase;
  List<String> phraseList;

  final Map<String, Classification> classifications;
  final List<String>? allCategoryList;

  final List<String> classOrder;
  final String? font;
  final String? diagramUrl;
  final String? observer;

  final bool isArchived;
  final bool isDeleted;
  final bool isPublic;
  PhraseModel(
    this.id, {
    required this.userRef,
    required this.phrase,
    required this.phraseList,
    required this.classifications,
    required this.classOrder,
    this.isArchived = false,
    this.isDeleted = false,
    this.isPublic = false,
    this.allCategoryList,
    this.font,
    this.diagramUrl,
    this.observer,
  });

  PhraseModel copyWith({
    UserRef? userRef,
    String? phrase,
    List<String>? phraseList,
    String? font,
    String? description,
    bool? isArchived,
    bool? isPublic,
    String? observer,
    bool observerSetNull = false,
    Map<String, Classification>? classifications,
    List<String>? allCategoryList,
    List<String>? classOrder,
    bool? isDeleted,
  }) {
    return PhraseModel(
      id,
      userRef: userRef ?? this.userRef,
      phrase: phrase ?? this.phrase,
      phraseList: phraseList ?? this.phraseList,
      font: font ?? this.font,
      diagramUrl: description ?? this.diagramUrl,
      isArchived: isArchived ?? this.isArchived,
      observer: observerSetNull ? null : observer ?? this.observer,
      classifications: classifications ?? this.classifications,
      allCategoryList: allCategoryList ?? this.allCategoryList,
      classOrder: classOrder ?? this.classOrder,
      isDeleted: isDeleted ?? this.isDeleted,
      isPublic: isPublic ?? this.isPublic,
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userRef'] = userRef.toMap();
    data['phrase'] = phrase;
    data['phraseList'] = phraseList.cast<dynamic>();

    data["classifications"] = <String, dynamic>{};
    for (var item in classifications.entries) {
      data["classifications"][item.key] = item.value.toMap();
    }
    data['classOrder'] = classOrder.cast<dynamic>();
    data['isArchived'] = isArchived;
    data['isDeleted'] = isDeleted;
    data['isPublic'] = isPublic;
    if (font != null) data['font'] = font;
    if (diagramUrl != null) data['diagramUrl'] = diagramUrl;
    data['observer'] = observer;
    return data;
  }

  factory PhraseModel.fromMap(String id, Map<String, dynamic> map) {
    Map<String, Classification>? _classifications = <String, Classification>{};
    if (map["classifications"] != null && map["classifications"] is Map) {
      _classifications = <String, Classification>{};
      for (var item in map["classifications"].entries) {
        _classifications[item.key] = Classification.fromMap(item.value);
      }
    }

    List<String> _classOrder = [];
    if (map["classOrder"] == null) {
      for (var item in map["classifications"].entries) {
        _classOrder.add(item.key);
      }
    } else {
      _classOrder = map['classOrder'].cast<String>();
    }
    var temp = PhraseModel(
      id,
      userRef: UserRef.fromMap(map['userRef']),
      phrase: map['phrase'],
      classifications: _classifications,
      classOrder: _classOrder,
      phraseList: map['phraseList'] == null
          ? setPhraseList(map['phrase'])
          : map['phraseList'].cast<String>(),
      isArchived: map['isArchived'],
      isDeleted: map['isDeleted'],
      isPublic: map['isPublic'] ?? false,
      font: map['font'],
      diagramUrl: map['diagramUrl'],
      observer: map['observer'],
    );
    return temp;
  }

  String toJson() => json.encode(toMap());

  factory PhraseModel.fromJson(String id, String source) =>
      PhraseModel.fromMap(id, json.decode(source));

  static List<String> setPhraseList(String phrase) {
    String word = '';
    List<String> _phraseList = [];
    for (var i = 0; i < phrase.length; i++) {
      if (phrase[i].contains(RegExp(
          r"[A-Za-záàãâäÁÀÃÂÄéèêëÉÈÊËíìîïÍÌÎÏóòõôöÓÒÕÖÔúùûüÚÙÛÜçÇñÑ0123456789]"))) {
        word += phrase[i];
      } else {
        if (word.isNotEmpty) {
          _phraseList.add(word);
          word = '';
        }
        _phraseList.add(phrase[i]);
      }
    }
    if (word.isNotEmpty) {
      _phraseList.add(word);
      word = '';
    }
    return _phraseList;
  }

  static List<String> setAllCategoryList(
      Map<String, Classification> classifications) {
    List<String> _allCategoryList = [];
    for (var item in classifications.entries) {
      _allCategoryList.addAll(item.value.categoryIdList);
    }
    return _allCategoryList;
  }

  @override
  String toString() {
    return 'PhraseModel( phrase: $phrase, font: $font, description: $diagramUrl, isArchived: $isArchived, observer: $observer,  isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PhraseModel &&
        other.userRef == userRef &&
        other.phrase == phrase &&
        other.phraseList == phraseList &&
        other.font == font &&
        other.diagramUrl == diagramUrl &&
        other.isArchived == isArchived &&
        other.isPublic == isPublic &&
        other.classOrder == classOrder &&
        other.observer == observer &&
        mapEquals(other.classifications, classifications) &&
        other.isDeleted == isDeleted;
  }

  @override
  int get hashCode {
    return userRef.hashCode ^
        phrase.hashCode ^
        phraseList.hashCode ^
        font.hashCode ^
        diagramUrl.hashCode ^
        isArchived.hashCode ^
        isPublic.hashCode ^
        observer.hashCode ^
        classOrder.hashCode ^
        classifications.hashCode ^
        isDeleted.hashCode;
  }
}

class Classification {
  final List<int> posPhraseList;
  final List<String> categoryIdList;
  Classification({
    required this.posPhraseList,
    required this.categoryIdList,
  });

  Classification copyWith({
    List<int>? posPhraseList,
    List<String>? categoryIdList,
  }) {
    return Classification(
      posPhraseList: posPhraseList ?? this.posPhraseList,
      categoryIdList: categoryIdList ?? this.categoryIdList,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'posPhraseList': posPhraseList,
      'categoryIdList': categoryIdList,
    };
  }

  factory Classification.fromMap(Map<String, dynamic> map) {
    return Classification(
      posPhraseList: List<int>.from(map['posPhraseList']),
      categoryIdList: List<String>.from(map['categoryIdList']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Classification.fromJson(String source) =>
      Classification.fromMap(json.decode(source));

  @override
  String toString() =>
      'Classification(posPhraseList: $posPhraseList, categoryIdList: $categoryIdList)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Classification &&
        listEquals(other.posPhraseList, posPhraseList) &&
        listEquals(other.categoryIdList, categoryIdList);
  }

  @override
  int get hashCode => posPhraseList.hashCode ^ categoryIdList.hashCode;
}
