class Case {
  final String id;
  final String title;
  final String description;
  final String caseNumber;
  final String caseType;
  final String status;
  final DateTime createdAt;
  final List<String>? attachments;
  final String? assignedLawyerId;

  Case({
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
}
