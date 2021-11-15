// import 'dart:convert';

// import 'package:flutter/foundation.dart';

import 'dart:convert';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class Agenda {
  final String date;
  final IList<String> atividades;
  Agenda({
    required this.date,
    required this.atividades,
  });

  Agenda copyWith({
    String? date,
    IList<String>? atividades,
  }) {
    return Agenda(
      date: date ?? this.date,
      atividades: atividades ?? this.atividades,
    );
  }

  Agenda copy() {
    return Agenda.fromJson(toJson());
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'atividades': atividades.unlock,
    };
  }

  factory Agenda.fromMap(Map<String, dynamic> map) {
    return Agenda(
      date: map['date'],
      atividades: IList(map['atividades'].cast<String>()),
    );
  }

  String toJson() => json.encode(toMap());

  factory Agenda.fromJson(String source) => Agenda.fromMap(json.decode(source));

  @override
  String toString() => 'Agenda(date: $date, atividades: $atividades)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Agenda &&
        runtimeType == other.runtimeType &&
        other.date == date &&
        other.atividades == atividades;
  }

  @override
  int get hashCode => date.hashCode ^ atividades.hashCode;
}
