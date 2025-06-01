import 'client_profile_model.dart';
import '../user/user_model.dart';

class ClientModel extends UserModel {
  final ClientProfileModel profileInfo;

  const ClientModel({
    required int id,
    required String name,
    required String email,
    required String role,
    required String profilePic,
    required String createdAt,
    required String updatedAt,
    required this.profileInfo,
  }) : super(
          id: id,
          name: name,
          email: email,
          role: role,
          profilePic: profilePic,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      profilePic: json['profile_pic'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      profileInfo: ClientProfileModel.fromJson(
          json['profile_info'] as Map<String, dynamic>),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    data['profile_info'] = profileInfo.toJson();
    return data;
  }

  @override
  ClientModel copyWith({
    int? id,
    String? name,
    String? email,
    String? role,
    String? profilePic,
    String? createdAt,
    String? updatedAt,
    ClientProfileModel? profileInfo,
  }) {
    return ClientModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      profilePic: profilePic ?? this.profilePic,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      profileInfo: profileInfo ?? this.profileInfo,
    );
  }
}
