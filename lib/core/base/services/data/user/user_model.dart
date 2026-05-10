import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String name;
  final String email;
  final String profilePhotoUrl;
  final String createdAt;
  final String updatedAt;

  const UserModel({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.profilePhotoUrl = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      profilePhotoUrl: json['profile_photo_url'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'profile_photo_url': profilePhotoUrl,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? profilePhotoUrl,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory UserModel.empty() => const UserModel();

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    profilePhotoUrl,
    createdAt,
    updatedAt,
  ];
}
