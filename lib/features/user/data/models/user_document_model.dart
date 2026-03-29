import 'package:equatable/equatable.dart';

class UserDocumentModel extends Equatable {
  final int? id;
  final String? file;
  final String? name;
  final bool? status;
  final int? public;
  final List<String>? orgList;
  final bool? professional;
  final String? description;

  const UserDocumentModel({
    this.id,
    this.file,
    this.name,
    this.status,
    this.public,
    this.orgList,
    this.professional,
    this.description,
  });

  factory UserDocumentModel.fromJson(Map<String, dynamic> json) {
    return UserDocumentModel(
      id: json['id'],
      file: json['file'],
      name: json['name'],
      status: json['status'],
      public: json['public'],
      orgList: json['org_list'] != null ? List<String>.from(json['org_list']) : null,
      professional: json['professional'],
      description: json['description'],
    );
  }

  @override
  List<Object?> get props => [id, file, name, status, public, orgList, professional, description];
}
