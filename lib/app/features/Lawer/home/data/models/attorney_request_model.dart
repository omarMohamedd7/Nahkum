class AttorneyRequestModel {
  final String id;
  final String caseType;
  final String clientName;
  final String caseStatus;
  final String caseNumber;
  final String description;

  AttorneyRequestModel({
    required this.id,
    required this.caseType,
    required this.clientName,
    required this.caseStatus,
    required this.caseNumber,
    required this.description,
  });

  factory AttorneyRequestModel.fromJson(Map<String, dynamic> json) {
    return AttorneyRequestModel(
      id: json['id'] ?? '',
      caseType: json['caseType'] ?? '',
      clientName: json['clientName'] ?? '',
      caseStatus: json['caseStatus'] ?? '',
      caseNumber: json['caseNumber'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caseType': caseType,
      'clientName': clientName,
      'caseStatus': caseStatus,
      'caseNumber': caseNumber,
      'description': description,
    };
  }
}
