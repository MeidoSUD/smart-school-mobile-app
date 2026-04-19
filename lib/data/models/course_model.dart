class Course {
  final int id;
  final String title;
  final String description;
  final String image;
  final int hours;
  final String teacherName;
  final int seats;
  final int enrolledStudents;
  final double price;
  final String category;
  final int? categoryId;
  final double rating;
  final List<String> topics;
  final String level;
  final DateTime startDate;
  final int? teacherId;
  final int? subjectId; // New
  final int? levelId;   // New
  final String? type;   // New
  final String? status; // New
  final Map<String, List<String>> availableTimes;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.hours,
    required this.teacherName,
    required this.seats,
    required this.enrolledStudents,
    required this.price,
    required this.category,
    this.categoryId,
    required this.rating,
    required this.topics,
    required this.level,
    required this.startDate,
    this.teacherId,
    this.subjectId,
    this.levelId,
    this.type,
    this.status,
    required this.availableTimes,
    this.rawSlots = const [],
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    final teacherBasic = json['teacher_basic'] as Map<String, dynamic>?;
    final teacherFirstName = teacherBasic?['first_name']?.toString() ?? '';
    final teacherLastName = teacherBasic?['last_name']?.toString() ?? '';
    final teacherName = '$teacherFirstName $teacherLastName'.trim();

    final categoryData = json['category'] as Map<String, dynamic>?;
    final categoryName =
        categoryData?['name_ar']?.toString() ??
        categoryData?['name']?.toString() ??
        'غير محدد';
    final categoryIdValue = categoryData?['id'] ?? json['category_id'];
    final categoryId = categoryIdValue != null
        ? (categoryIdValue is int
              ? categoryIdValue
              : int.tryParse(categoryIdValue.toString()))
        : null;

    final coverImageData =
        json['cover_image'] as Map<String, dynamic>? ??
        json['coverImage'] as Map<String, dynamic>?;
    String imageUrl =
        'https://images.unsplash.com/photo-1512941937669-90a1b58e7e9c?w=400';
    if (coverImageData != null) {
      imageUrl =
          coverImageData['url']?.toString() ??
          coverImageData['path']?.toString() ??
          imageUrl;
    }

    final teacherReviews = json['teacher_reviews'] as List? ?? [];
    double rating = 0.0;
    if (teacherReviews.isNotEmpty) {
      final ratings = teacherReviews
          .where((r) => r != null && r['rating'] != null)
          .map((r) => (r['rating'] as num).toDouble())
          .toList();
      if (ratings.isNotEmpty) {
        rating = ratings.reduce((a, b) => a + b) / ratings.length;
      }
    }

    final courseLessons = json['courselessons'] as List? ?? [];
    final topics = courseLessons
        .where((lesson) => lesson != null && lesson['title'] != null)
        .map((lesson) => lesson['title'].toString())
        .toList();
    final topicsList = topics.isNotEmpty ? topics : ['دورة تدريبية'];

    final educationLevel = json['education_level'] as Map<String, dynamic>?;
    final levelName =
        educationLevel?['name_ar']?.toString() ??
        educationLevel?['name']?.toString() ??
        'متوسط';

    final availabilitySlots = json['available_slots'] as List? ?? [];
    DateTime startDate = DateTime.now().add(const Duration(days: 7));
    if (availabilitySlots.isNotEmpty) {
      final firstSlot = availabilitySlots.first;
      if (firstSlot != null && firstSlot['date'] != null) {
        try {
          startDate = DateTime.parse(firstSlot['date'].toString());
        } catch (e) {
          startDate = DateTime.now().add(const Duration(days: 7));
        }
      }
    }

    final priceValue = json['price'] != null
        ? (json['price'] is num
              ? json['price'].toDouble()
              : double.tryParse(json['price'].toString()) ?? 0.0)
        : 0.0;

    final durationHours = json['duration_hours'] != null
        ? (json['duration_hours'] is int
              ? json['duration_hours']
              : int.tryParse(json['duration_hours'].toString()) ?? 0)
        : 0;

    final titleValue =
        json['title_ar']?.toString() ??
        json['name']?.toString() ??
        json['title']?.toString() ??
        'دورة تدريبية';

    final descriptionValue = json['description']?.toString() ?? '';

    return Course(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      title: titleValue,
      description: descriptionValue,
      image: imageUrl,
      hours: durationHours,
      teacherName: teacherName.isNotEmpty ? teacherName : 'مدرس غير محدد',
      seats: 30,
      enrolledStudents: 0,
      price: priceValue,
      category: categoryName,
      categoryId: categoryId,
      rating: rating,
      topics: topicsList,
      level: levelName,
      startDate: startDate,
      teacherId: json['teacher_id'] is int
          ? json['teacher_id']
          : int.tryParse(json['teacher_id']?.toString() ?? ''),
      subjectId: json['subject_id'] is int
          ? json['subject_id']
          : int.tryParse(json['subject_id']?.toString() ?? ''),
      levelId: json['education_level_id'] is int
          ? json['education_level_id']
          : int.tryParse(json['education_level_id']?.toString() ?? ''),
      type: json['course_type']?.toString(),
      status: json['status']?.toString(),
      availableTimes: _parseAvailableTimes(availabilitySlots),
      rawSlots: availabilitySlots,
    );
  }

  final List<dynamic> rawSlots;

  static Map<String, List<String>> _parseAvailableTimes(List<dynamic> slots) {
    if (slots.isEmpty) return {};

    final Map<String, List<String>> grouped = {};

    // Arabic Day Names mapping (Dart weekday: 1=Mon, 7=Sun)
    const dayNames = {
      1: 'الاثنين',
      2: 'الثلاثاء',
      3: 'الأربعاء',
      4: 'الخميس',
      5: 'الجمعة',
      6: 'السبت',
      7: 'الأحد',
    };

    for (var slot in slots) {
      if (slot == null) continue;
      // Skip if booked or unavailable
      if (slot['is_booked'] == true || slot['is_booked'] == 1) continue;
      if (slot['is_available'] == false || slot['is_available'] == 0) continue;

      String? dateKey;
      if (slot['date'] != null) {
        try {
          final date = DateTime.parse(slot['date'].toString());
          dateKey = dayNames[date.weekday];
        } catch (e) {
          dateKey = slot['date'].toString();
        }
      } else if (slot['day_number'] != null) {
        final dayNum = int.tryParse(slot['day_number'].toString());
        if (dayNum != null) {
          switch (dayNum) {
            case 1:
              dateKey = 'الأحد';
              break;
            case 2:
              dateKey = 'الاثنين';
              break;
            case 3:
              dateKey = 'الثلاثاء';
              break;
            case 4:
              dateKey = 'الأربعاء';
              break;
            case 5:
              dateKey = 'الخميس';
              break;
            case 6:
              dateKey = 'الجمعة';
              break;
            case 7:
              dateKey = 'السبت';
              break;
          }
        }
      }

      if (dateKey != null) {
        final startTime = slot['start_time']?.toString() ?? '';
        if (startTime.isNotEmpty) {
          final timeParts = startTime.split(':');
          final timeStr = timeParts.length >= 2
              ? '${timeParts[0]}:${timeParts[1]}'
              : startTime;

          if (!grouped.containsKey(dateKey)) {
            grouped[dateKey] = [];
          }
          if (!grouped[dateKey]!.contains(timeStr)) {
            grouped[dateKey]!.add(timeStr);
          }
        }
      }
    }

    final order = [
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
    ];

    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) {
        int indexA = order.indexOf(a);
        int indexB = order.indexOf(b);
        if (indexA == -1) indexA = 999;
        if (indexB == -1) indexB = 999;
        return indexA.compareTo(indexB);
      });

    final Map<String, List<String>> sortedGrouped = {};
    for (var key in sortedKeys) {
      sortedGrouped[key] = grouped[key]!..sort();
    }

    return sortedGrouped;
  }

  int? getSlotId(String dayName, String time) {
    const dayNames = {
      1: 'الاثنين',
      2: 'الثلاثاء',
      3: 'الأربعاء',
      4: 'الخميس',
      5: 'الجمعة',
      6: 'السبت',
      7: 'الأحد',
    };

    for (var slot in rawSlots) {
      if (slot == null) continue;

      String? dateKey;
      if (slot['date'] != null) {
        try {
          final date = DateTime.parse(slot['date'].toString());
          dateKey = dayNames[date.weekday];
        } catch (e) {
          dateKey = slot['date'].toString();
        }
      } else if (slot['day_number'] != null) {
        final dayNum = int.tryParse(slot['day_number'].toString());
        if (dayNum != null) {
          switch (dayNum) {
            case 1:
              dateKey = 'الأحد';
              break;
            case 2:
              dateKey = 'الاثنين';
              break;
            case 3:
              dateKey = 'الثلاثاء';
              break;
            case 4:
              dateKey = 'الأربعاء';
              break;
            case 5:
              dateKey = 'الخميس';
              break;
            case 6:
              dateKey = 'الجمعة';
              break;
            case 7:
              dateKey = 'السبت';
              break;
          }
        }
      }

      if (dateKey == dayName) {
        final startTime = slot['start_time']?.toString() ?? '';
        String timeStr = startTime;
        // Normalize time string (remove seconds if present)
        if (startTime.isNotEmpty) {
          final timeParts = startTime.split(':');
          timeStr = timeParts.length >= 2
              ? '${timeParts[0]}:${timeParts[1]}'
              : startTime;
        }

        if (timeStr == time) {
          return slot['id'];
        }
      }
    }
    return null;
  }

  int get availableSeats => seats - enrolledStudents;
}
