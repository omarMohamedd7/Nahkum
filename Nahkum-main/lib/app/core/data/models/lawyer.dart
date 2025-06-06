class Lawyer {
  final String id;
  final String name;
  final String location;
  final String description;
  final double price;
  final String imageUrl;
  final String specialization;

  const Lawyer({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.specialization,
  });

  @override
  String toString() {
    return 'Lawyer(id: $id, name: $name, location: $location, specialization: $specialization)';
  }
}
