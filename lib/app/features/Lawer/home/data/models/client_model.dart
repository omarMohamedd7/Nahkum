import 'package:flutter/foundation.dart';

class ClientModel {
  final String id;
  final String name;
  final String caseType;
  final String caseNumber;
  final String? imageUrl;
  final DateTime createdAt;

  const ClientModel({
    required this.id,
    required this.name,
    required this.caseType,
    required this.caseNumber,
    this.imageUrl,
    required this.createdAt,
  });

  ClientModel copyWith({
    String? id,
    String? name,
    String? caseType,
    String? caseNumber,
    String? imageUrl,
    DateTime? createdAt,
  }) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      caseType: caseType ?? this.caseType,
      caseNumber: caseNumber ?? this.caseNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
