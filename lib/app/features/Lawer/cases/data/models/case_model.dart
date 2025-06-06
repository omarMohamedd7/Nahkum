import 'package:flutter/foundation.dart';

enum CaseStatus { active, closed }

class CaseModel {
  final String id;
  final String title;
  final String clientName;
  final String caseNumber;
  final String description;
  final CaseStatus status;
  final DateTime createdAt;

  const CaseModel({
    required this.id,
    required this.title,
    required this.clientName,
    required this.caseNumber,
    required this.description,
    required this.status,
    required this.createdAt,
  });

  CaseModel copyWith({
    String? id,
    String? title,
    String? clientName,
    String? caseNumber,
    String? description,
    CaseStatus? status,
    DateTime? createdAt,
  }) {
    return CaseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      clientName: clientName ?? this.clientName,
      caseNumber: caseNumber ?? this.caseNumber,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
