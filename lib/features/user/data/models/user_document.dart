// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserDocument extends Equatable {
  final int id;
  final String file;
  final String name;
  final bool status;
  final String public;
  final List<String> orgList;
  final bool professional;
  final String description;

  const UserDocument({
    this.id = 0,
    this.file = '',
    this.name = '',
    this.status = false,
    this.public = '',
    this.orgList = const [],
    this.professional = false,
    this.description = '',
  });

  @override
  List<Object> get props {
    return [
      id,
      file,
      name,
      status,
      public,
      orgList,
      professional,
      description,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'file': file,
      'name': name,
      'status': status,
      'public': public,
      'org_list': orgList,
      'professional': professional,
      'description': description,
    };
  }

  factory UserDocument.fromMap(Map<String, dynamic> map) {
    return UserDocument(
      id: map['id'] as int,
      file: map['file'] as String,
      name: map['name'] as String,
      status: map['status'] as bool,
      public: map['public'] as String,
      orgList: List<String>.from((map['org_list'] as List<String>)),
      professional: map['professional'] as bool,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDocument.fromJson(Object? source) => UserDocument.fromMap(source as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
