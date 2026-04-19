import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../booking/booking_flow_screen.dart';

class TeacherDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> teacher;

  const TeacherDetailsScreen({super.key, required this.teacher});

  @override
  State<TeacherDetailsScreen> createState() => _TeacherDetailsScreenState();
}

class _TeacherDetailsScreenState extends State<TeacherDetailsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;
    final mediaQuery = MediaQuery.of(context);
    final isTablet = mediaQuery.size.shortestSide >= 600;
    // Robust status bar height check: uses viewPadding if available, otherwise padding, with a safe fallback of 35.0
    final statusBarHeight = mediaQuery.viewPadding.top > 0
        ? mediaQuery.viewPadding.top
        : (mediaQuery.padding.top > 0 ? mediaQuery.padding.top : 35.0);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Stack(
        children: [
          // Main Scrollable Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Cover Image Section
                Stack(
                  children: [
                    // Cover Image
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: _buildCoverImage(theme),
                    ),
                    // Gradient Overlay
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Profile Content
                Transform.translate(
                  offset: const Offset(0, -60),
                  child: Column(
                    children: [
                      // Profile Picture
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            widget.teacher["profile_image"] ??
                                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150",
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Name & Specialization
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 40 : 24,
                        ),
                        child: Column(
                          children: [
                            Text(
                              "${widget.teacher["first_name"] ?? ''} ${widget.teacher["last_name"] ?? ''}",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                widget.teacher["specialization"] ?? loc.teacher,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: theme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),

                            // Stats Row
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _StatBadge(
                                    icon: Icons.star_rounded,
                                    value:
                                        widget.teacher["rating"]?.toString() ??
                                        "0.0",
                                    label: loc.rating,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 16),
                                  _StatBadge(
                                    icon: Icons.people_rounded,
                                    value:
                                        widget.teacher["total_students"]
                                            ?.toString() ??
                                        "0",
                                    label: loc.student,
                                    color: theme.primaryColor,
                                  ),
                                  const SizedBox(width: 16),
                                  _StatBadge(
                                    icon: Icons.school_rounded,
                                    value:
                                        "${widget.teacher["completed_lessons"] ?? 0}",
                                    label: loc.lessonsLabel,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 16),
                                  _StatBadge(
                                    icon: Icons.payments_rounded,
                                    value:
                                        "${widget.teacher["individual_hour_price"]?.toInt() ?? 0} ${loc.currency}",
                                    label: loc.price,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Content Sections
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 40 : 24,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Bio
                            if (widget.teacher["bio"] != null)
                              _InfoCard(
                                title: loc.aboutTeacher,
                                icon: Icons.info_outline,
                                child: Text(
                                  widget.teacher["bio"],
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade700,
                                    height: 1.6,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 16),

                            // Services
                            _InfoCard(
                              title: loc.providedServices,
                              icon: Icons.work_outline,
                              child: Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: (widget.teacher["services"] as List? ?? [])
                                    .map((service) {
                                      final isAr =
                                          Localizations.localeOf(context)
                                              .languageCode ==
                                          'ar';
                                      final name =
                                          isAr
                                              ? (service["name_ar"] ??
                                                  service["name_en"])
                                              : (service["name_en"] ??
                                                  service["name_ar"]);
                                      final key =
                                          (service["key_name"] ?? "")
                                              .toString()
                                              .toLowerCase();
                                      final id = service["id"];

                                      IconData icon = Icons.work_outline;
                                      Color color = theme.primaryColor;

                                      if (key == 'private_lesson' || id == 3) {
                                        icon = Icons.person;
                                        color = theme.primaryColor;
                                      } else if (key == 'courses' ||
                                          key == 'training_courses' ||
                                          id == 4) {
                                        icon = Icons.groups;
                                        color = Colors.green;
                                      } else if (key == 'language_learning' ||
                                          id == 2) {
                                        icon = Icons.language;
                                        color = Colors.orange;
                                      } else if (key == 'sessions' ||
                                          key == 'consultation' ||
                                          id == 5) {
                                        icon = Icons.video_call;
                                        color = Colors.purple;
                                      }

                                      return _ServiceChip(
                                        label: name ?? "",
                                        icon: icon,
                                        color: color,
                                      );
                                    })
                                    .toList(),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Pricing
                            if (widget.teacher["teach_individual"] == 1 ||
                                widget.teacher["teach_group"] == 1 ||
                                widget.teacher["teach_languages"] == 1)
                              Row(
                                children: [
                                  if (widget.teacher["teach_individual"] == 1 ||
                                      widget.teacher["teach_languages"] == 1)
                                    Expanded(
                                      child: _PriceCard(
                                        title: loc.privateLesson,
                                        price:
                                            widget
                                                .teacher["individual_hour_price"]
                                                ?.toInt() ??
                                            0,
                                        icon: Icons.person,
                                        color: theme.primaryColor,
                                      ),
                                    ),
                                  if ((widget.teacher["teach_individual"] ==
                                              1 ||
                                          widget.teacher["teach_languages"] ==
                                              1) &&
                                      widget.teacher["teach_group"] == 1)
                                    const SizedBox(width: 16),
                                  // if (widget.teacher["teach_group"] == 1)
                                  //   Expanded(
                                  //     child: _PriceCard(
                                  //       title: "درس جماعي",
                                  //       price:
                                  //           widget.teacher["group_hour_price"]
                                  //               ?.toInt() ??
                                  //           0,
                                  //       icon: Icons.groups,
                                  //       color: Colors.green,
                                  //     ),
                                  //   ),
                                ],
                              ),
                            const SizedBox(height: 16),

                            // Subjects
                            if (widget.teacher["teacher_subjects"] != null &&
                                (widget.teacher["teacher_subjects"] as List)
                                    .isNotEmpty)
                              _InfoCard(
                                title: loc.subjectsTaught,
                                icon: Icons.menu_book,
                                child: Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children:
                                      (widget.teacher["teacher_subjects"]
                                              as List)
                                          .map(
                                            (s) => Chip(
                                              label: Text(s["title"] ?? ""),
                                              backgroundColor:
                                                  Colors.purple.shade50,
                                              labelStyle: TextStyle(
                                                color: Colors.purple.shade700,
                                                fontSize: 13,
                                              ),
                                            ),
                                          )
                                          .toList(),
                                ),
                              ),
                            const SizedBox(height: 16),

                            // Languages
                            if (widget.teacher["languages"] != null &&
                                (widget.teacher["languages"] as List)
                                    .isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _InfoCard(
                                  title: loc.languages,
                                  icon: Icons.translate,
                                  child: Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children:
                                        (widget.teacher["languages"] as List)
                                            .map((l) {
                                              final isAr =
                                                  Localizations.localeOf(
                                                    context,
                                                  ).languageCode ==
                                                  'ar';
                                              return Chip(
                                                label: Text(
                                                  isAr
                                                      ? (l["name_ar"] ??
                                                            l["name_en"] ??
                                                            "")
                                                      : (l["name_en"] ??
                                                            l["name_ar"] ??
                                                            ""),
                                                ),
                                                backgroundColor:
                                                    Colors.orange.shade50,
                                                labelStyle: TextStyle(
                                                  color: Colors.orange.shade900,
                                                  fontSize: 13,
                                                ),
                                              );
                                            })
                                            .toList(),
                                  ),
                                ),
                              ),

                            // Certificates Section
                            _buildCertificatesSection(theme),
                            const SizedBox(height: 16),

                            // Reviews Section
                            _buildReviewsSection(theme),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Floating Back Button
          Positioned(
            top: statusBarHeight + 4,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_forward, size: 22),
                onPressed: () => Navigator.pop(context),
                color: Colors.black87,
              ),
            ),
          ),

          // Share Button
          Positioned(
            top: statusBarHeight + 4,
            left: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(Icons.share, size: 22),
                onPressed: () {},
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(theme, loc),
    );
  }

  Widget _buildCoverImage(ThemeData theme) {
    try {
      if (widget.teacher["cover_video"] != null) {
        return Container(
          color: Colors.black,
          child: const Center(
            child: Icon(
              Icons.play_circle_outline,
              size: 80,
              color: Colors.white70,
            ),
          ),
        );
      }

      String? coverUrl;
      final attachments = widget.teacher["attachments"] as List?;
      if (attachments != null) {
        final coverAttachment = attachments.firstWhere(
          (a) => a["type"] == "cover_image",
          orElse: () => null,
        );
        if (coverAttachment != null) {
          coverUrl = coverAttachment["file_path"];
        }
      }

      coverUrl ??= widget.teacher["cover_image"];

      return Image.network(
        coverUrl ??
            "https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800",
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [theme.primaryColor.withOpacity(0.8), theme.primaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      );
    } catch (e) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.primaryColor.withOpacity(0.8), theme.primaryColor],
          ),
        ),
      );
    }
  }

  Widget _buildCertificatesSection(ThemeData theme) {
    final loc = AppLocalizations.of(context)!;
    List certificates = [];
    try {
      final attachments = widget.teacher["attachments"] as List?;
      if (attachments != null) {
        certificates = attachments
            .where((a) => a["type"] == "certificates")
            .toList();
      }
      if (certificates.isEmpty) {
        certificates = widget.teacher["certificates"] as List? ?? [];
      }
    } catch (e) {
      certificates = [];
    }

    if (certificates.isEmpty) return const SizedBox.shrink();

    return _InfoCard(
      title: loc.certificates,
      icon: Icons.workspace_premium,
      child: Column(
        children: certificates.take(3).map((cert) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.verified,
                    color: theme.primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cert["title"] ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        cert["issuer"] ?? cert["fileName"] ?? "",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if ((cert["certificate_url"] ?? cert["file_path"]) != null)
                  Icon(Icons.download, color: theme.primaryColor, size: 20),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildReviewsSection(ThemeData theme) {
    final loc = AppLocalizations.of(context)!;
    final reviews = widget.teacher["reviews"] as List? ?? [];

    if (reviews.isEmpty) return const SizedBox.shrink();

    return _InfoCard(
      title: loc.reviews,
      icon: Icons.rate_review,
      child: Column(
        children: reviews.take(3).map((review) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                        review["student_image"] ?? "",
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review["student_name"] ?? "",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            children: List.generate(
                              5,
                              (i) => Icon(
                                i < (review["rating"] ?? 0)
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 14,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      review["date"] ?? "",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  review["comment"] ?? "",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 13,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBottomBar(ThemeData theme, AppLocalizations loc) {
    final hasLessons =
        widget.teacher["teach_individual"] == 1 ||
        widget.teacher["teach_group"] == 1 ||
        widget.teacher["teach_languages"] == 1;
    final hasSessions = widget.teacher["offer_sessions"] == 1;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (hasLessons)
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            BookingFlowScreen(teacher: widget.teacher),
                      ),
                    );
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(loc.book),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            if (hasLessons && hasSessions) const SizedBox(width: 12),
            if (hasSessions)
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.video_call),
                  label: Text(loc.bookSession),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatBadge({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _InfoCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 22),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _ServiceChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _ServiceChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _PriceCard extends StatelessWidget {
  final String title;
  final int price;
  final IconData icon;
  final Color color;

  const _PriceCard({
    required this.title,
    required this.price,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "$price",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        height: 1.0,
                      ),
                    ),
                    const WidgetSpan(child: SizedBox(width: 4)),
                    TextSpan(
                      text: loc.currency,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  loc.perHour,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
