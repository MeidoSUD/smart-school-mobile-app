class StudentRegistrationRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String password;
  final String? gender;
  final String? nationality;

  StudentRegistrationRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.gender,
    this.nationality,
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
    };
  }
}
