import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/logger.dart';
import '../../presentation/state/review_provider.dart';

class SessionReviewWidget extends ConsumerStatefulWidget {
  final int sessionId;
  final int teacherId;
  final String teacherName;
  final VoidCallback? onReviewAdded;

  const SessionReviewWidget({
    super.key,
    required this.sessionId,
    required this.teacherId,
    required this.teacherName,
    this.onReviewAdded,
  });

  @override
  ConsumerState<SessionReviewWidget> createState() =>
      _SessionReviewWidgetState();
}

class _SessionReviewWidgetState extends ConsumerState<SessionReviewWidget> {
  Map<String, dynamic>? _review;
  bool _canReview = false;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadReview();
    });
  }

  Future<void> _loadReview() async {
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final reviewService = ref.read(reviewServiceProvider);
      Logger.log("Loading review for session: ${widget.sessionId}");
      final result = await reviewService.getSessionReview(widget.sessionId);

      if (!mounted) return;
      if (result['success'] == true) {
        Logger.log("Review loaded successfully");
        setState(() {
          _review = result['review'];
          _canReview = result['can_review'] ?? false;
          _isLoading = false;
        });
      } else {
        Logger.log("Failed to load review: ${result['message']}");
        setState(() {
          _error = result['message'];
          _isLoading = false;
        });
      }
    } catch (e) {
      Logger.log("Error catching review: $e");
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _showAddReviewDialog() async {
    double rating = 5.0;
    final commentController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تقييم المعلم', textAlign: TextAlign.right),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                widget.teacherName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 16),
              const Text('التقييم', textAlign: TextAlign.right),
              const SizedBox(height: 8),
              Center(
                child: RatingBar.builder(
                  initialRating: 5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 40,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Colors.amber),
                  onRatingUpdate: (value) {
                    rating = value;
                  },
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: commentController,
                decoration: const InputDecoration(
                  labelText: 'التعليق (اختياري)',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('إرسال'),
          ),
        ],
      ),
    );

    if (result == true && mounted) {
      await _submitReview(
        rating: rating.toInt(),
        comment: commentController.text.trim(),
      );
    }
  }

  Future<void> _submitReview({
    required int rating,
    required String comment,
  }) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      final reviewService = ref.read(reviewServiceProvider);
      final result = await reviewService.addTeacherReview(
        teacherId: widget.teacherId,
        sessionId: widget.sessionId,
        rating: rating,
        comment: comment.isEmpty ? null : comment,
      );

      if (mounted) {
        Navigator.pop(context); // Close loading dialog

        if (result['success'] == true) {
          setState(() {
            _review = result['data'];
            _canReview = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إضافة التقييم بنجاح'),
              backgroundColor: Colors.green,
            ),
          );

          widget.onReviewAdded?.call();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('فشل إضافة التقييم: ${result['message']}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context); // Close loading dialog

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('فشل إضافة التقييم: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error != null) {
      return Card(
        margin: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 8),
              Text(
                'حدث خطأ في تحميل التقييم',
                style: TextStyle(
                  color: Colors.red[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _error!,
                style: TextStyle(color: Colors.red[400], fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadReview,
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      );
    }

    if (_review != null) {
      return _buildExistingReview();
    }

    if (_canReview) {
      return _buildAddReviewButton();
    }

    return const SizedBox.shrink();
  }

  Widget _buildExistingReview() {
    final review = _review!;
    final rating = review['rating'] as int;
    final comment = review['comment'] as String?;
    final reviewer = review['reviewer'];
    String reviewerName = 'مجهول';
    if (reviewer != null) {
      if (reviewer['name'] != null && reviewer['name'].toString().isNotEmpty) {
        reviewerName = reviewer['name'];
      } else if (reviewer['first_name'] != null) {
        reviewerName =
            '${reviewer['first_name']} ${reviewer['last_name'] ?? ''}'.trim();
      }
    }
    final createdAt = DateTime.tryParse(review['created_at'] ?? '');

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (createdAt != null)
                  Text(
                    _formatDate(createdAt),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                const Text(
                  'التقييم',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '$rating/5',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                ...List.generate(
                  5,
                  (index) => Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 24,
                  ),
                ),
              ],
            ),
            if (comment != null && comment.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  comment,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
            const SizedBox(height: 8),
            Text(
              'بواسطة: $reviewerName',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddReviewButton() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(Icons.star_outline, size: 48, color: Colors.amber),
            const SizedBox(height: 8),
            const Text(
              'قيّم تجربتك مع المعلم',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'ساعد الآخرين في اختيار المعلم المناسب',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _showAddReviewDialog,
                icon: const Icon(Icons.star),
                label: const Text('إضافة تقييم'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'اليوم';
    } else if (difference.inDays == 1) {
      return 'أمس';
    } else if (difference.inDays < 7) {
      return 'منذ ${difference.inDays} أيام';
    } else if (difference.inDays < 30) {
      return 'منذ ${(difference.inDays / 7).floor()} أسابيع';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
