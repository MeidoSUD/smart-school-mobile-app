import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/logger.dart';
import '../../../data/repositories/order_repository.dart';

class OrderBottomSheet extends StatefulWidget {
  final VoidCallback? onOrderPlaced;

  const OrderBottomSheet({super.key, this.onOrderPlaced});

  @override
  State<OrderBottomSheet> createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  SessionType _selectedType = SessionType.online;
  int? _selectedEducationLevelId;
  int? _selectedClassId;
  int? _selectedSubjectId;
  bool _isLoading = false;
  bool _isLoadingData = false;

  final OrderRepository _orderRepository = OrderRepository();

  List<Map<String, dynamic>> _educationLevels = [];
  List<Map<String, dynamic>> _classes = [];
  List<Map<String, dynamic>> _subjects = [];

  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
    _loadEducationLevels();
  }

  Future<void> _loadEducationLevels() async {
    setState(() => _isLoadingData = true);
    try {
      final levels = await _orderRepository.getEducationLevels();
      Logger.log("Loaded education levels: ${levels.length}, data: $levels");
      setState(() {
        _educationLevels = levels;
        _isLoadingData = false;
      });
    } catch (e) {
      Logger.log("Error loading education levels: $e");
      setState(() => _isLoadingData = false);
      if (mounted) {
        _showErrorSnackBar(
          AppLocalizations.of(context)!.loadingEducationLevelsFailed,
        );
      }
    }
  }

  Future<void> _loadClasses(int educationLevelId) async {
    setState(() {
      _isLoadingData = true;
      _selectedClassId = null;
      _selectedSubjectId = null;
      _classes = [];
      _subjects = [];
    });

    try {
      final classes = await _orderRepository.getClassesByLevel(
        educationLevelId,
      );
      Logger.log(
        "Loaded classes for level $educationLevelId: ${classes.length}, data: $classes",
      );
      setState(() {
        _classes = classes;
        _isLoadingData = false;
      });
    } catch (e) {
      Logger.log("Error loading classes: $e");
      setState(() => _isLoadingData = false);
      if (mounted) {
        _showErrorSnackBar(AppLocalizations.of(context)!.loadingGradesFailed);
      }
    }
  }

  Future<void> _loadSubjects(int classId) async {
    setState(() {
      _isLoadingData = true;
      _selectedSubjectId = null;
      _subjects = [];
    });

    try {
      final subjects = await _orderRepository.getSubjectsByClass(classId);
      setState(() {
        _subjects = subjects;
        _isLoadingData = false;
      });
    } catch (e) {
      Logger.log("Error loading subjects: $e");
      setState(() => _isLoadingData = false);
      if (mounted) {
        _showErrorSnackBar(AppLocalizations.of(context)!.loadingSubjectsFailed);
      }
    }
  }

  int _toInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // Removed _totalPrice calculation as price is removed

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value * size.height * 0.3),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Container(
              height: size.height * 0.9,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildHeader(context),
                  Expanded(child: _buildContent(context)),
                  _buildFooter(context),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.school_outlined,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "طلب عاجل", // Order Urgent
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.primaryColor,
                      ),
                    ),
                    Text(
                      "هذا الطلب للحالات العاجلة عندما لا يمكنك انتظار المواعيد المتاحة للمعلمين.", // Subtitle for urgent situations
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded, color: Colors.grey),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEducationSection(context),
            const SizedBox(height: 24),

            _buildDateTimeSection(context),
            const SizedBox(height: 24),
            _buildSessionTypeSection(context),
            const SizedBox(height: 24),
            _buildDescriptionSection(context),
            const SizedBox(height: 24),
            // Removed Pricing Summary and Duration/Price sections
          ],
        ),
      ),
    );
  }

  Widget _buildEducationSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.academicDetails,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(height: 16),
        if (_isLoadingData && _educationLevels.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
          )
        else if (_educationLevels.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                AppLocalizations.of(context)!.noEducationLevelsAvailable,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ),
          )
        else ...[
          _buildDropdownField(
            label: AppLocalizations.of(context)!.educationLevel,
            hint: AppLocalizations.of(context)!.selectEducationLevel,
            icon: Icons.school_outlined,
            value: _educationLevels
                .firstWhere(
                  (level) => level['id'] == _selectedEducationLevelId,
                  orElse: () => <String, dynamic>{},
                )['name_ar']
                ?.toString(),
            items: _educationLevels
                .map(
                  (level) => DropdownMenuItem<String>(
                    value: level['name_ar']?.toString() ?? '',
                    child: Text(level['name_ar']?.toString() ?? ''),
                  ),
                )
                .toList(),
            onChanged: (value) {
              final level = _educationLevels.firstWhere(
                (l) => l['name_ar']?.toString() == value,
              );
              final levelId = _toInt(level['id']);
              Logger.log(
                "Selected education level: $level, converted ID: $levelId",
              );
              setState(() {
                _selectedEducationLevelId = levelId;
              });
              _loadClasses(levelId);
            },
            validator: (value) => value == null
                ? AppLocalizations.of(context)!.selectEducationLevel
                : null,
          ),
          const SizedBox(height: 16),
          if (_isLoadingData && _selectedEducationLevelId != null)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CircularProgressIndicator(),
              ),
            )
          else
            _buildDropdownField(
              label: AppLocalizations.of(context)!.grade,
              hint: _selectedEducationLevelId == null
                  ? AppLocalizations.of(context)!.selectEducationLevelFirst
                  : _classes.isEmpty
                  ? AppLocalizations.of(context)!.noGradesAvailable
                  : AppLocalizations.of(context)!.selectGrade,
              icon: Icons.class_outlined,
              value: _classes
                  .firstWhere(
                    (c) => c['id'] == _selectedClassId,
                    orElse: () => <String, dynamic>{},
                  )['name_ar']
                  ?.toString(),
              items: _classes
                  .map(
                    (classItem) => DropdownMenuItem<String>(
                      value: classItem['name_ar']?.toString() ?? '',
                      child: Text(classItem['name_ar']?.toString() ?? ''),
                    ),
                  )
                  .toList(),
              onChanged: _selectedEducationLevelId == null || _classes.isEmpty
                  ? (value) {}
                  : (value) {
                      final classItem = _classes.firstWhere(
                        (c) => c['name_ar']?.toString() == value,
                      );
                      final classId = _toInt(classItem['id']);
                      Logger.log(
                        "Selected class: $classItem, converted ID: $classId",
                      );
                      setState(() {
                        _selectedClassId = classId;
                      });
                      _loadSubjects(classId);
                    },
              validator: (value) => value == null
                  ? AppLocalizations.of(context)!.selectGrade
                  : null,
            ),
          const SizedBox(height: 16),
          if (_isLoadingData && _selectedClassId != null)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: CircularProgressIndicator(),
              ),
            )
          else
            _buildDropdownField(
              label: AppLocalizations.of(context)!.subject,
              hint: _selectedClassId == null
                  ? AppLocalizations.of(context)!.selectGradeFirst
                  : _subjects.isEmpty
                  ? AppLocalizations.of(context)!.noSubjectsAvailable
                  : AppLocalizations.of(context)!.selectSubject,
              icon: Icons.book_outlined,
              value: _subjects
                  .firstWhere(
                    (s) => _toInt(s['id']) == _selectedSubjectId,
                    orElse: () => <String, dynamic>{},
                  )['name_ar']
                  ?.toString(),
              items: _subjects
                  .map(
                    (subject) => DropdownMenuItem<String>(
                      value: subject['name_ar']?.toString() ?? '',
                      child: Text(subject['name_ar']?.toString() ?? ''),
                    ),
                  )
                  .toList(),
              onChanged: _selectedClassId == null || _subjects.isEmpty
                  ? (value) {}
                  : (value) {
                      final subject = _subjects.firstWhere(
                        (s) => s['name_ar']?.toString() == value,
                      );
                      final subjectId = _toInt(subject['id']);
                      Logger.log(
                        "Selected subject: $subject, converted ID: $subjectId",
                      );
                      setState(() {
                        _selectedSubjectId = subjectId;
                      });
                    },
              validator: (value) => value == null
                  ? AppLocalizations.of(context)!.selectSubject
                  : null,
            ),
        ],
      ],
    );
  }

  Widget _buildSessionTypeSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.sessionType,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildSessionTypeCard(
                context,
                SessionType.online,
                Icons.videocam_outlined,
                AppLocalizations.of(context)!.online,
                AppLocalizations.of(context)!.videoSession,
              ),
            ),
            // Removed In-Person option
          ],
        ),
      ],
    );
  }

  Widget _buildSessionTypeCard(
    BuildContext context,
    SessionType type,
    IconData icon,
    String title,
    String subtitle,
  ) {
    final theme = Theme.of(context);
    final isSelected = _selectedType == type;

    return GestureDetector(
      onTap: () => setState(() => _selectedType = type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.primaryColor.withOpacity(0.1)
              : Colors.white,
          border: Border.all(
            color: isSelected
                ? theme.primaryColor
                : Colors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected ? theme.primaryColor : Colors.grey[600],
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? theme.primaryColor : Colors.black87,
              ),
            ),
            Text(
              subtitle,
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.dateTime,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildInputField(
                controller: _dateController,
                label: AppLocalizations.of(context)!.date,
                hint: AppLocalizations.of(context)!.selectDate,
                icon: Icons.calendar_today_outlined,
                readOnly: true,
                onTap: () => _selectDate(context),
                validator: (value) => value == null || value.isEmpty
                    ? AppLocalizations.of(context)!.selectDate
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildInputField(
                controller: TextEditingController(
                  text: _selectedTime?.format(context) ?? '',
                ),
                label: AppLocalizations.of(context)!.time,
                hint: AppLocalizations.of(context)!.selectTime,
                icon: Icons.access_time_outlined,
                readOnly: true,
                onTap: () => _selectTime(context),
                validator: (value) => value == null || value.isEmpty
                    ? AppLocalizations.of(context)!.selectTime
                    : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Removed _buildDurationAndPriceSection

  Widget _buildDescriptionSection(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.sessionDescription,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        _buildInputField(
          controller: _descriptionController,
          label: AppLocalizations.of(context)!.sessionDetails,
          hint: AppLocalizations.of(context)!.writeSessionDetails,
          icon: Icons.description_outlined,
          maxLines: 3,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return AppLocalizations.of(context)!.descriptionRequired;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String hint,
    required IconData icon,
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    final theme = Theme.of(context);

    return DropdownButtonFormField<String>(
      initialValue: value,
      items: items,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 20, color: theme.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.primaryColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
  }) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 20, color: theme.primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.primaryColor, width: 2),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  // Removed _buildPricingSummary

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _handlePlaceOrder,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    AppLocalizations.of(context)!.sendRequest,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      locale: const Locale('ar'),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
        _dateController.text = '${date.day}/${date.month}/${date.year}';
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  Future<void> _handlePlaceOrder() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null) {
      _showErrorSnackBar(AppLocalizations.of(context)!.selectDate);
      return;
    }
    if (_selectedTime == null) {
      _showErrorSnackBar(AppLocalizations.of(context)!.selectTime);
      return;
    }
    if (_selectedSubjectId == null) {
      _showErrorSnackBar(AppLocalizations.of(context)!.selectSubject);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final hours = 1.0; // Fixed 1 hour for urgent requests
      final startTime = _selectedTime!;

      final dateStr =
          "${_selectedDate!.year}-${_selectedDate!.month.toString().padLeft(2, '0')}-${_selectedDate!.day.toString().padLeft(2, '0')}";

      final startTimeStr =
          "${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}";

      final endTime = TimeOfDay(
        hour: (startTime.hour + hours.toInt()) % 24,
        minute: startTime.minute,
      );
      final endTimeStr =
          "${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}";

      final availabilitySlots = [
        {'date': dateStr, 'start_time': startTimeStr, 'end_time': endTimeStr},
      ];

      int? minPrice; // No price for urgent requests per UI change
      int? maxPrice;

      final orderType = _selectedType == SessionType.online
          ? 'online'
          : 'in_house';

      final result = await _orderRepository.createOrder(
        subjectId: _selectedSubjectId!,
        classId: _selectedClassId,
        educationLevelId: _selectedEducationLevelId,
        orderType: orderType,
        minPrice: minPrice,
        maxPrice: maxPrice,
        notes: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
        availabilitySlots: availabilitySlots,
      );

      setState(() => _isLoading = false);

      if (mounted) {
        if (result['success'] == true) {
          widget.onOrderPlaced?.call();
          Navigator.pop(context);
          _showSuccessSnackBar(
            result['message'] ??
                AppLocalizations.of(context)!.requestSentSuccess,
          );
        } else {
          _showErrorSnackBar(
            result['message'] ??
                AppLocalizations.of(context)!.requestSentFailed,
          );
        }
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        _showErrorSnackBar(
          '${AppLocalizations.of(context)!.errorPrefix}${e.toString()}',
        );
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }
}

enum SessionType { online, inPerson }

// Usage function to show the bottom sheet
void showOrderBottomSheet(BuildContext context, {VoidCallback? onOrderPlaced}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => OrderBottomSheet(onOrderPlaced: onOrderPlaced),
  );
}
