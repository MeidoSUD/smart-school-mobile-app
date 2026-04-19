class CertificatesModel {
  final String path;
  CertificatesModel({required this.path});

  factory CertificatesModel.fromJson(Map<String, dynamic> json) {
    return CertificatesModel(path: json['path'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'path': path};
  }

  CertificatesModel copyWith({String? path}) {
    return CertificatesModel(path: path ?? this.path);
  }
}
