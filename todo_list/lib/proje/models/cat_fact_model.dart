// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_list/proje/widgets/furure_provider_page.dart';

class CatFactModel {
  final String? fact;
  final int? length;
  CatFactModel({
    this.fact,
    this.length,
  });

        

  CatFactModel copyWith({
    String? fact,
    int? length,
  }) {
    return CatFactModel(
      fact: fact ?? this.fact,
      length: length ?? this.length,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fact': fact,
      'length': length,
    };
  } 
  factory CatFactModel.fromMap(Map<String, dynamic> map) {
    return CatFactModel(
      fact: map['fact'] != null ? map['fact'] as String : null,
      length: map['length'] != null ? map['length'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CatFactModel.fromJson(String source) => CatFactModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CatFactModel(fact: $fact, length: $length)';

  @override
  bool operator ==(covariant CatFactModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.fact == fact &&
      other.length == length;
  }

  @override
  int get hashCode => fact.hashCode ^ length.hashCode;
}
