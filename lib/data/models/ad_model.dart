class AdModel {
  final int id;
  final String imageUrl;
  final String? description;
  final String? linkUrl;
  final String? ctaText;
  final String? platform;

  const AdModel({
    required this.id,
    required this.imageUrl,
    this.description,
    this.linkUrl,
    this.ctaText,
    this.platform,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) {
    return AdModel(
      id: json['id'] as int,
      imageUrl: json['image_url'] as String,
      description: json['description'] as String?,
      linkUrl: json['link_url'] as String?,
      ctaText: json['cta_text'] as String?,
      platform: json['platform'] as String?,
    );
  }
}
