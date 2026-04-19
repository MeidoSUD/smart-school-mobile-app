import 'package:geniuses_school/data/models/user_profile_model.dart';

class UserModel {
  final int id;
  final String email;
  final String? token;
  final String first_name;
  final String last_name;
  final String? nationality;
  final String gender;
  final String? password;
  final String phone_number;
  final int role_id;
  final DateTime? email_verified_at;
  final bool verified;
  final BigInt? verification_code;
  final String? social_provider;
  final String? social_provider_id;
  final bool is_active;
  final UserProfileModel? profile;

  UserModel({
    required this.id,
    required this.first_name,
    required this.last_name,
    this.password,
    this.nationality,
    required this.gender,
    required this.role_id,
    required this.phone_number,
    required this.email,
    this.token,
    this.profile,
    this.email_verified_at,
    required this.is_active,
    this.social_provider,
    this.social_provider_id,
    this.verification_code,
    this.verified = false,
  });

  UserModel copyWith({
    int? id,
    String? email,
    String? token,
    String? first_name,
    String? last_name,
    String? nationality,
    String? gender,
    String? password,
    String? phone_number,
    int? role_id,
    DateTime? email_verified_at,
    bool? verified,
    BigInt? verification_code,
    String? social_provider,
    String? social_provider_id,
    bool? is_active,
    UserProfileModel? profile,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      token: token ?? this.token,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      nationality: nationality ?? this.nationality,
      gender: gender ?? this.gender,
      password: password ?? this.password,
      phone_number: phone_number ?? this.phone_number,
      role_id: role_id ?? this.role_id,
      profile: profile ?? this.profile,
      email_verified_at: email_verified_at ?? this.email_verified_at,
      is_active: is_active ?? this.is_active,
      social_provider: social_provider ?? this.social_provider,
      social_provider_id: social_provider_id ?? this.social_provider_id,
      verification_code: verification_code ?? this.verification_code,
      verified: verified ?? this.verified,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = json;
    String? token = json['token']?.toString();

    // Handle nested structures: {user: {data: {...}}} or {user: {...}} or direct {...}
    if (json.containsKey('user') && json['user'] is Map<String, dynamic>) {
      final userMap = json['user'] as Map<String, dynamic>;
      if (userMap.containsKey('data') &&
          userMap['data'] is Map<String, dynamic>) {
        data = userMap['data'] as Map<String, dynamic>;
      } else {
        data = userMap;
      }
    } else if (json.containsKey('data') &&
        json['data'] is Map<String, dynamic>) {
      // Sometimes it's {data: {id: ...}}
      return UserModel.fromJson(json['data'] as Map<String, dynamic>);
    }

    return UserModel(
      id: data['id'] ?? 0,
      first_name: data['first_name'] ?? '',
      last_name: data['last_name'] ?? '',
      password: data['password'],
      gender: data['gender'] ?? '',
      nationality: data['nationality'],
      phone_number: data['phone_number'] ?? '',
      role_id: data['role_id'] ?? 1,
      email: data['email'] ?? '',
      token: token ?? data['token'] ?? '',
      profile: data['profile'] != null
          ? UserProfileModel.fromJson(data['profile'])
          : null,
      email_verified_at: data['email_verified_at'] != null
          ? DateTime.tryParse(data['email_verified_at'].toString())
          : null,
      is_active:
          (data['is_active'] == 1 ||
          data['is_active'] == true ||
          (data['profile'] != null &&
              (data['profile']['is_active'] == 1 ||
                  data['profile']['is_active'] == true))),
      verified: (data['verified'] == 1 || data['verified'] == true),
      social_provider: data['social_provider'],
      social_provider_id: data['social_provider_id'],
      verification_code: data['verification_code'] != null
          ? BigInt.tryParse(data['verification_code'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': first_name,
      'last_name': last_name,
      'password': password,
      'gender': gender,
      'nationality': nationality,
      'phone_number': phone_number,
      'role_id': role_id,
      'email': email,
      'token': token,
      'profile': profile?.toJson(),
      'email_verified_at': email_verified_at?.toIso8601String(),
      'is_active': is_active,
      'social_provider': social_provider,
      'social_provider_id': social_provider_id,
      'verification_code': verification_code?.toString(),
      'verified': verified,
    };
  }
}
