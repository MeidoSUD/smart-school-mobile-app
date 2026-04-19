import 'dart:io';

class TeacherRegistrationRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String? gender;
  final String? nationality;
  final int? serviceId;
  final String? bio;
  final File? certificate;
  final File? cv;

  TeacherRegistrationRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.gender,
    this.nationality,
    this.serviceId,
    this.bio,
    this.certificate,
    this.cv,
  });

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phoneNumber,
      "password": password,
      "password_confirmation": password,
      if (gender != null) "gender": gender,
      if (nationality != null) "nationality": nationality,
      if (serviceId != null) "service_id": serviceId,
      if (bio != null) "bio": bio,
      // Files are handled separately for FormData, but we can include them here if needed for debugging or other purposes.
      // However, for API calls usually we convert this map to FormData and add files.
    };
  }
}
