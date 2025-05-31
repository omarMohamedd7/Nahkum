import 'dart:io';

class PublishCaseModel {
  final String? id;
  final String? caseType;
  final String description;
  final List<File> attachments;
  final DateTime createdAt;
  final String status;
  final String? targetCity;

  PublishCaseModel({
    this.id,
    this.caseType,
    required this.description,
    required this.attachments,
    DateTime? createdAt,
    this.status = 'pending',
    this.targetCity,
  }) : createdAt = createdAt ?? DateTime.now();

  PublishCaseModel copyWith({
    String? id,
    String? caseType,
    String? description,
    List<File>? attachments,
    DateTime? createdAt,
    String? status,
    String? targetCity,
  }) {
    return PublishCaseModel(
      id: id ?? this.id,
      caseType: caseType ?? this.caseType,
      description: description ?? this.description,
      attachments: attachments ?? this.attachments,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
      targetCity: targetCity ?? this.targetCity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caseType': caseType,
      'description': description,
      'attachmentsCount': attachments.length,
      'createdAt': createdAt.toIso8601String(),
      'status': status,
      'targetCity': targetCity,
    };
  }

  factory PublishCaseModel.fromJson(Map<String, dynamic> json) {
    return PublishCaseModel(
      id: json['id'],
      caseType: json['caseType'],
      description: json['description'],
      attachments: [], // Files need to be loaded separately
      createdAt: DateTime.parse(json['createdAt']),
      status: json['status'],
      targetCity: json['targetCity'],
    );
  }
}
