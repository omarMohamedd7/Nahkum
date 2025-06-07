class LawyerSessionModel {
  final String id;
  final String caseType;
  final String clientName;
  final String caseStatus;
  final String caseNumber;
  final String date;

  LawyerSessionModel({
    required this.id,
    required this.caseType,
    required this.clientName,
    required this.caseStatus,
    required this.caseNumber,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caseType': caseType,
      'clientName': clientName,
      'caseStatus': caseStatus,
      'caseNumber': caseNumber,
      'date': date,
    };
  }
}
