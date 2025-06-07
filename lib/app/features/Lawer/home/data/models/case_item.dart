class CaseItem {
  final int caseId;
  final String caseType;
  final String clientName;
  final String caseNumber;
  final String status;
  final String description;

  CaseItem({
    required this.caseId,
    required this.caseType,
    required this.clientName,
    required this.caseNumber,
    required this.status,
    required this.description,
  });

  factory CaseItem.fromJson(Map<String, dynamic> json) {
    return CaseItem(
      caseId: json['case_id'],
      caseType: json['case_type'],
      clientName: json['client_name'] ?? '',
      caseNumber: json['case_number'],
      status: json['status'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'case_id': caseId,
      'case_type': caseType,
      'client_name': clientName,
      'case_number': caseNumber,
      'status': status,
      'description': description,
    };
  }
}
