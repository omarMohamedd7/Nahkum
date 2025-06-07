class PublishedCaseModel {
  final String id;
  final String caseType;
  final String clientName;
  final String city;
  final String description;

  PublishedCaseModel({
    required this.id,
    required this.caseType,
    required this.clientName,
    required this.city,
    required this.description,
  });

  factory PublishedCaseModel.fromJson(Map<String, dynamic> json) {
    return PublishedCaseModel(
      id: json['id'] ?? '',
      caseType: json['caseType'] ?? '',
      clientName: json['clientName'] ?? '',
      city: json['city'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caseType': caseType,
      'clientName': clientName,
      'city': city,
      'description': description,
    };
  }
}
