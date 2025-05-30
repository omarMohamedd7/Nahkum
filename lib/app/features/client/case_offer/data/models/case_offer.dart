class CaseOffer {
  final String id;
  final String caseNumber;
  final String caseType;
  final String lawyerId;
  final String lawyerName;
  final String description;
  final double price;
  final String status;
  final DateTime createdAt;

  CaseOffer({
    required this.id,
    required this.caseNumber,
    required this.caseType,
    required this.lawyerId,
    required this.lawyerName,
    required this.description,
    required this.price,
    required this.status,
    required this.createdAt,
  });

  factory CaseOffer.fromJson(Map<String, dynamic> json) {
    return CaseOffer(
      id: json['id'] as String,
      caseNumber: json['caseNumber'] as String,
      caseType: json['caseType'] as String,
      lawyerId: json['lawyerId'] as String,
      lawyerName: json['lawyerName'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'caseNumber': caseNumber,
      'caseType': caseType,
      'lawyerId': lawyerId,
      'lawyerName': lawyerName,
      'description': description,
      'price': price,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
