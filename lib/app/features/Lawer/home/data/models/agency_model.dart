class AgencyModel {
  final String id;
  final String caseType;
  final String clientName;
  final String caseNumber;
  final String description;

  const AgencyModel({
    required this.id,
    required this.caseType,
    required this.clientName,
    required this.caseNumber,
    required this.description,
  });

  factory AgencyModel.fromJson(Map<String, dynamic> json) {
    return AgencyModel(
      id: json['id'] ?? '',
      caseType: json['caseType'] ?? '',
      clientName: json['clientName'] ?? '',
      caseNumber: json['caseNumber'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caseType': caseType,
      'clientName': clientName,
      'caseNumber': caseNumber,
      'description': description,
    };
  }
}
