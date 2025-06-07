class Client {
  final int id;
  final String name;
  final String phoneNumber;
  final String city;
  final String profileImageUrl;

  Client({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.city,
    required this.profileImageUrl,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phone_number'],
      city: json['city'],
      profileImageUrl: json['profile_image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'city': city,
      'profile_image_url': profileImageUrl,
    };
  }
}
