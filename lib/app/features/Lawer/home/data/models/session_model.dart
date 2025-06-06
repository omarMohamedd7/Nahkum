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

  factory LawyerSessionModel.fromJson(Map<String, dynamic> json) {
    return LawyerSessionModel(
      id: json['id'] ?? '',
      caseType: json['caseType'] ?? '',
      clientName: json['clientName'] ?? '',
      caseStatus: json['caseStatus'] ?? '',
      caseNumber: json['caseNumber'] ?? '',
      date: json['date'] ?? '',
    );
  }

  // Convert from the existing CaseModel
  factory LawyerSessionModel.fromCaseModel(dynamic caseModel,
      {String date = ''}) {
    if (caseModel == null) {
      return LawyerSessionModel(
        id: '',
        caseType: '',
        clientName: '',
        caseStatus: '',
        caseNumber: '',
        date: date,
      );
    }

    // Handle both Map<String, dynamic> and CaseModel
    if (caseModel is Map<String, dynamic>) {
      return LawyerSessionModel(
        id: caseModel['id'] ?? '',
        caseType: caseModel['caseType'] ?? '',
        clientName: caseModel['title'] ?? '', // Use title as client name
        caseStatus: caseModel['status'] ?? '',
        caseNumber: caseModel['caseNumber'] ?? '',
        date: date,
      );
    } else {
      return LawyerSessionModel(
        id: caseModel.id,
        caseType: caseModel.caseType,
        clientName: caseModel.title,
        caseStatus: caseModel.status,
        caseNumber: caseModel.caseNumber,
        date: date,
      );
    }
  }

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
