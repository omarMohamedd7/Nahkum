class LawyerModel {
  final String id;
  final String name;
  final String location;
  final String description;
  final double price;
  final String imageUrl;
  final String specialization;

  const LawyerModel({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.specialization,
  });

  LawyerModel copyWith({
    String? id,
    String? name,
    String? location,
    String? description,
    double? price,
    String? imageUrl,
    String? specialization,
  }) {
    return LawyerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      specialization: specialization ?? this.specialization,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'specialization': specialization,
    };
  }

  factory LawyerModel.fromJson(Map<String, dynamic> json) {
    return LawyerModel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['imageUrl'],
      specialization: json['specialization'],
    );
  }
}
