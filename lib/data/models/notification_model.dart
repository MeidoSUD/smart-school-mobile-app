
class NotificationModel {
  final int id;
  final String title;
  final String message;
  final DateTime time;
  final String type;
  final bool isRead;
  final Map<String, dynamic>? data;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.isRead,
     this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      time: DateTime.parse(json['created_at']),
      type: json['type'],
      isRead: json['is_read'] == 1,
      data: json['data'] != null
          ? Map<String, dynamic>.from(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'time': time.toIso8601String(),
      'type': type,
      'isRead': isRead,
      'data': data,
    };
  }

  NotificationModel copyWith({
    int? id,
    String? title,
    String? message,
    DateTime? time,
    String? type,
    bool? isRead,
    Map<String, dynamic>? data
  }) {
    return NotificationModel(
      id: id ?? this.id,
      title: title ?? this.title,
      message: message ?? this.message,
      time: time ?? this.time,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      data: data ?? this.data,
    );
  }

  // Helper method to get relative time string (منذ دقيقتين, منذ ساعة, etc.)
  String getRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'الآن';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return 'منذ $minutes ${minutes == 1 ? 'دقيقة' : minutes == 2 ? 'دقيقتين' : 'دقائق'}';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return 'منذ $hours ${hours == 1 ? 'ساعة' : hours == 2 ? 'ساعتين' : 'ساعات'}';
    } else if (difference.inDays == 1) {
      return 'أمس';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} ${difference.inDays == 2 ? 'يومين' : 'أيام'}';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return 'منذ $weeks ${weeks == 1 ? 'أسبوع' : weeks == 2 ? 'أسبوعين' : 'أسابيع'}';
    } else {
      final months = (difference.inDays / 30).floor();
      return 'منذ $months ${months == 1 ? 'شهر' : months == 2 ? 'شهرين' : 'أشهر'}';
    }
  }
}