import 'dart:core';

class Case {
  final String id;
  final String title;
  final String description;
  final String caseNumber;
  final String caseType;
  final String status;
  final String? lawyerId;
  final List<String> attachments;

  Case(
      {required this.id,
      required this.title,
      required this.description,
      required this.status,
      required this.caseNumber,
      this.lawyerId,
      required this.attachments,
      required this.caseType});

  factory Case.fromJson(Map<String, dynamic> json) {
    return Case(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      status: json['status'] as String,
      caseNumber: json['clientId'] as String,
      caseType: json['caseType'] as String,
      lawyerId: json['lawyerId'] as String?,
      attachments: List<String>.from(json['attachments'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'caseNumber': caseNumber,
      'lawyerId': lawyerId,
      'attachments': attachments,
    };
  }
}
