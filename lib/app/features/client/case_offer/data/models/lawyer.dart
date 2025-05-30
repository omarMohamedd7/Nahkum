class Lawyer {
  final String id;
  final String name;
  final String specialization;
  final String location;
  final String imageUrl;
  final double rating;

  Lawyer({
    required this.id,
    required this.name,
    required this.specialization,
    required this.location,
    required this.imageUrl,
    required this.rating,
  });

  factory Lawyer.fromJson(Map<String, dynamic> json) {
    return Lawyer(
      id: json['id'] as String,
      name: json['name'] as String,
      specialization: json['specialization'] as String,
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'location': location,
      'imageUrl': imageUrl,
      'rating': rating,
    };
  }
}
