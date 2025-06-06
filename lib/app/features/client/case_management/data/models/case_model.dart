class CaseModel {
  final String id;
  final String title;
  final String description;
  final String caseNumber;
  final String caseType;
  final String status;
  final DateTime createdAt;
  final List<String>? attachments;
  final String? assignedLawyerId;

  CaseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.caseNumber,
    required this.caseType,
    required this.status,
    required this.createdAt,
    this.attachments,
    this.assignedLawyerId,
  });

  CaseModel copyWith({
    String? id,
    String? title,
    String? description,
    String? caseNumber,
    String? caseType,
    String? status,
    DateTime? createdAt,
    List<String>? attachments,
    String? assignedLawyerId,
  }) {
    return CaseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      caseNumber: caseNumber ?? this.caseNumber,
      caseType: caseType ?? this.caseType,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      attachments: attachments ?? this.attachments,
      assignedLawyerId: assignedLawyerId ?? this.assignedLawyerId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'caseNumber': caseNumber,
      'caseType': caseType,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'attachments': attachments,
      'assignedLawyerId': assignedLawyerId,
    };
  }

  factory CaseModel.fromJson(Map<String, dynamic> json) {
    return CaseModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      caseNumber: json['caseNumber'],
      caseType: json['caseType'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      attachments: json['attachments'] != null
          ? List<String>.from(json['attachments'])
          : null,
      assignedLawyerId: json['assignedLawyerId'],
    );
  }
}
