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

  // Convert from the existing PublishCaseModel
  factory PublishedCaseModel.fromPublishCaseModel(Map<String, dynamic> model) {
    return PublishedCaseModel(
      id: model['id'] ?? '',
      caseType: model['caseType'] ?? '',
      clientName: model['clientName'] ?? '',
      city: model['targetCity'] ?? '',
      description: model['description'] ?? '',
    );
  }

  // Convert directly from the existing PublishCaseModel class
  factory PublishedCaseModel.fromPublishCase(dynamic publishCase) {
    if (publishCase == null) {
      return PublishedCaseModel(
        id: '',
        caseType: '',
        clientName: '',
        city: '',
        description: '',
      );
    }

    // Handle both Map<String, dynamic> and PublishCaseModel
    if (publishCase is Map<String, dynamic>) {
      return PublishedCaseModel.fromPublishCaseModel(publishCase);
    } else {
      return PublishedCaseModel(
        id: publishCase.id ?? '',
        caseType: publishCase.caseType ?? '',
        clientName:
            'مستخدم', // Client name might not be available in PublishCaseModel
        city: publishCase.targetCity ?? '',
        description: publishCase.description,
      );
    }
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
