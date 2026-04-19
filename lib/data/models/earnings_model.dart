class EarningsModel {
  final int totalLessons;
  final double? totalEarnings;
  final double? todayEarnings;
  final double? monthEarnings;

  EarningsModel({
    this.totalLessons = 0,
    this.totalEarnings = 0,
    this.todayEarnings = 0,
    this.monthEarnings = 0,
  });

  factory EarningsModel.fromJson(Map<String, dynamic> json) {
    return EarningsModel(
      totalLessons: json['total_lessons'] ?? 0,
      totalEarnings: (json['total_earnings'] != null)
          ? double.tryParse(json['total_earnings'].toString())
          : null,
      todayEarnings: (json['today_earnings'] != null)
          ? double.tryParse(json['today_earnings'].toString())
          : null,
      monthEarnings: (json['month_earnings'] != null)
          ? double.tryParse(json['month_earnings'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_lessons': totalLessons,
      'total_earnings': totalEarnings,
      'today_earnings': todayEarnings,
      'month_earnings': monthEarnings,
    };
  }

  EarningsModel copyWith({
    int? totalLessons,
    double? totalEarnings,
    double? todayEarnings,
    double? monthEarnings,
  }) {
    return EarningsModel(
      totalLessons: totalLessons ?? this.totalLessons,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      todayEarnings: todayEarnings ?? this.todayEarnings,
      monthEarnings: monthEarnings ?? this.monthEarnings,
    );
  }
}
