import 'package:geniuses_school/data/models/course_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

// ---------------- CourseCard ----------------
class CourseCard extends StatefulWidget {
  final Course course;
  final VoidCallback onDelete;
  final ValueChanged<Course> onEdit;

  const CourseCard({
    super.key,
    required this.course,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  void _openEditSheet(BuildContext context) {
    widget.onEdit(widget.course);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              widget.course.image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey.shade300,
                child: const Icon(Icons.broken_image, size: 50),
              ),
            ),
          ),

          // Title & Description
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.course.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  widget.course.description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),

                // Course Details Row
                Row(
                  children: [
                    Expanded(
                      child: _infoItem(
                        Icons.person,
                        widget.course.teacherName,
                        isTruncated: true,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _infoItem(
                      Icons.access_time,
                      l10n.hoursShort(widget.course.hours),
                    ),
                    const SizedBox(width: 8),
                    _infoItem(
                      Icons.event_seat,
                      l10n.seatsCount(widget.course.seats),
                    ),
                    const SizedBox(width: 8),
                    _infoItem(
                      Icons.attach_money,
                      widget.course.price.toStringAsFixed(2),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Edit / Delete Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () => _openEditSheet(context),
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  label: Text(l10n.edit),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: widget.onDelete,
                  icon: const Icon(Icons.delete, color: Colors.red),
                  label: Text(l10n.delete),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for course details icons
  Widget _infoItem(IconData icon, String text, {bool isTruncated = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade700),
        const SizedBox(width: 4),
        if (isTruncated)
          Flexible(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )
        else
          Text(
            text,
            style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
          ),
      ],
    );
  }
}
