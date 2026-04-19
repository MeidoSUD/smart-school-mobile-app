import 'package:geniuses_school/app_keys.dart';
import 'package:geniuses_school/core/utils/logger.dart';
import 'package:geniuses_school/data/models/all_subjects_model.dart';
import 'package:geniuses_school/data/models/class_model.dart';
import 'package:geniuses_school/data/models/level_model.dart';
import 'package:geniuses_school/data/models/subject_model.dart';
import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/state/levels_provider.dart';
import 'package:geniuses_school/presentation/state/subjects_provider.dart';
import 'package:geniuses_school/presentation/widgets/common/error_screen_widget.dart';
import 'package:geniuses_school/presentation/widgets/common/subject_shimmer_widget.dart';
import 'package:geniuses_school/presentation/widgets/common/subjects_manage_summer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchoolClass {
  int id;
  String name;
  int levelId;
  List<SubjectTemplate> availableSubjects;

  SchoolClass({
    required this.id,
    required this.name,
    required this.levelId,
    required this.availableSubjects,
  });
}

class EducationLevel {
  int id;
  String name;

  EducationLevel({required this.id, required this.name});
}

class SubjectTemplate {
  int id;
  String name;

  SubjectTemplate({required this.id, required this.name});
}

// Dummy Data
List<LevelModel> levelsData = [];

List<SchoolClass> classesData = [
  SchoolClass(
    id: 1,
    name: ' الصف الرابع الابتدائي',
    levelId: 1,
    availableSubjects: [
      SubjectTemplate(id: 41, name: 'رياضيات'),
      SubjectTemplate(id: 42, name: 'لغة عربية'),
      SubjectTemplate(id: 43, name: 'علوم'),
      SubjectTemplate(id: 44, name: 'لغة إنجليزية'),
      SubjectTemplate(id: 45, name: 'تربية إسلامية'),
      SubjectTemplate(id: 46, name: 'تاريخ'),
    ],
  ),
  SchoolClass(
    id: 5,
    name: 'الصف الخامس الابتدائي',
    levelId: 1,
    availableSubjects: [
      SubjectTemplate(id: 47, name: 'رياضيات'),
      SubjectTemplate(id: 48, name: 'لغة عربية'),
      SubjectTemplate(id: 49, name: 'علوم'),
      SubjectTemplate(id: 50, name: 'لغة إنجليزية'),
      SubjectTemplate(id: 51, name: 'تربية إسلامية'),
      SubjectTemplate(id: 52, name: 'جغرافيا'),
    ],
  ),
  SchoolClass(
    id: 7,
    name: 'الصف الأول المتوسط',
    levelId: 2,
    availableSubjects: [
      SubjectTemplate(id: 53, name: 'رياضيات'),
      SubjectTemplate(id: 54, name: 'فيزياء'),
      SubjectTemplate(id: 55, name: 'كيمياء'),
      SubjectTemplate(id: 56, name: 'أحياء'),
      SubjectTemplate(id: 57, name: 'لغة عربية'),
      SubjectTemplate(id: 58, name: 'لغة إنجليزية'),
    ],
  ),
];

class SubjectsManageScreen extends ConsumerStatefulWidget {
  const SubjectsManageScreen({super.key});

  @override
  ConsumerState<SubjectsManageScreen> createState() =>
      _SubjectsManageScreenState();
}

class _SubjectsManageScreenState extends ConsumerState<SubjectsManageScreen> {
  int? selectedLevelId;
  int? selectedClassId;

  List<SubjectModel> get filteredSubjects {
    final SubjectState = ref.watch(subjectsProvider);
    return SubjectState.value!.where((subject) {
      if (selectedLevelId != null && subject.levelId != selectedLevelId) {
        return false;
      }
      if (selectedClassId != null && subject.classId != selectedClassId) {
        return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final SubjectState = ref.watch(subjectsProvider);
    final subjectS = ref.watch(subjectsProvider);

    return subjectS.when(
      data: (data) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: Text(
              l10n.manageSubjectsTitle,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: theme.primaryColor,
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: Column(
            children: [
              _buildFilters(theme, l10n),
              Expanded(
                child: filteredSubjects.isEmpty
                    ? _buildEmptyState(theme, l10n)
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredSubjects.length,
                        itemBuilder: (context, index) {
                          final subject = filteredSubjects[index];
                          return _SubjectCard(
                            subject: subject,
                            onDelete: () => _deleteSubject(subject, l10n),
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FloatingActionButton.extended(
                onPressed: _addSubject,
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                icon: const Icon(Icons.add_rounded),
                label: Text(l10n.addSubject),
              ),
              const SizedBox(width: 12),
              FloatingActionButton.extended(
                onPressed: () {
                  // Implement save functionality here
                  Logger.log(
                    "Saved subjects: ${SubjectState.value!.map((s) => s.id).toList()}",
                  );
                  ref.read(subjectsProvider.notifier).updateSubject().then((_) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(l10n.changesSaved)));
                  });
                },
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                icon: const Icon(Icons.save),
                label: const Text('حفظ'),
              ),
            ],
          ),
        );
      },
      error: (err, stack) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Text(
                '${AppLocalizations.of(context)!.errorPrefix}${err.toString()}',
              ),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        });
        return ErrorScreenWidget(message: err.toString());
      },
      loading: () => SubjectManageShimmer(),
    );
  }

  Widget _buidEmptyScreen(ThemeData theme) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.manageSubjectsTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildFilters(theme, l10n),
          Expanded(child: _buildEmptyState(theme, l10n)),
        ],
      ),
    );
  }

  Widget _buildFilters(ThemeData theme, AppLocalizations l10n) {
    final levelsState = ref.watch(levelsProvider);
    return levelsState.when(
      data: (levels) {
        return Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.filterBy,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _FilterChip(
                      label: selectedLevelId == null
                          ? l10n.educationalLevel
                          : levels
                                .firstWhere((l) => l.id == selectedLevelId)
                                .name,
                      isSelected: selectedLevelId != null,
                      icon: Icons.school_outlined,
                      onTap: () => _showLevelFilter(l10n),
                      onClear: selectedLevelId != null
                          ? () {
                              setState(() {
                                selectedLevelId = null;
                              });
                            }
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _FilterChip(
                      label: selectedClassId == null
                          ? l10n.schoolClass
                          : levels
                                .expand((level) => level.classes!)
                                .firstWhere((c) => c.id == selectedClassId)
                                .name,
                      isSelected: selectedClassId != null,
                      icon: Icons.class_outlined,
                      onTap: () => _showClassFilter(l10n),
                      onClear: selectedClassId != null
                          ? () {
                              setState(() {
                                selectedClassId = null;
                              });
                            }
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
      loading: () => Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SubjectShimmerWidget(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 60,
            ),
            const SizedBox(width: 2),
            SubjectShimmerWidget(
              width: MediaQuery.of(context).size.width * 0.35,
              height: 60,
            ),
          ],
        ),
      ),
      error: (err, stack) => Center(
        child: Text(AppLocalizations.of(context)!.errorLabel(err.toString())),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.book_outlined,
              size: 60,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.noSubjects,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.startAddingSubjects,
            style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  void _showLevelFilter(AppLocalizations l10n) {
    final levelsState = ref.watch(levelsProvider);
    return levelsState.when(
      data: (levels) {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.selectLevel,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ...levels.map((level) {
                  final isSelected = selectedLevelId == level.id;
                  return ListTile(
                    leading: Icon(
                      isSelected
                          ? Icons.radio_button_checked
                          : Icons.radio_button_off,
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                    ),
                    title: Text(level.name),
                    onTap: () {
                      setState(() {
                        selectedLevelId = level.id;
                        selectedClassId = null;
                      });
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Text('${AppLocalizations.of(context)!.errorPrefix}$err'),
      ),
    );
  }

  void _showClassFilter(AppLocalizations l10n) {
    final levelsState = ref.watch(levelsProvider);
    return levelsState.when(
      data: (levels) {
        final availableClasses = selectedLevelId == null
            ? levels.expand((level) => level.classes!)
            : levels
                  .expand((level) => level.classes!)
                  .where((c) => c.levelId == selectedLevelId)
                  .toList();
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (context) => Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.selectClass,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (availableClasses.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(child: Text(l10n.selectLevelFirst)),
                    )
                  else
                    ...availableClasses.map((schoolClass) {
                      final isSelected = selectedClassId == schoolClass.id;
                      return ListTile(
                        leading: Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey,
                        ),
                        title: Text(schoolClass.name),
                        onTap: () {
                          setState(() {
                            selectedClassId = schoolClass.id;
                          });
                          Navigator.pop(context);
                        },
                      );
                    }),
                ],
              ),
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Text('${AppLocalizations.of(context)!.errorPrefix}$err'),
      ),
    );
  }

  void _addSubject() {
    final SubjectState = ref.watch(subjectsProvider);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _SelectSubjectFlow(
          onSubjectSelected: (levelId, classId, subjectTemplate) {
            setState(() {
              SubjectState.value!.add(
                SubjectModel(
                  id: subjectTemplate.id,
                  name: subjectTemplate.name,

                  levelId: levelId,
                  classId: classId,
                ),
              );
            });
          },
        ),
      ),
    );
  }

  void _deleteSubject(SubjectModel subject, AppLocalizations l10n) {
    final SubjectState = ref.watch(subjectsProvider);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(l10n.confirmDelete),
        content: Text(l10n.confirmDeleteSubject(subject.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.cancel,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() => SubjectState.value!.remove(subject));
              Navigator.pop(context);
            },
            child: Text(l10n.delete, style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

// Filter Chip Widget
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final IconData icon;
  final VoidCallback onTap;
  final VoidCallback? onClear;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.icon,
    required this.onTap,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.primaryColor.withOpacity(0.1)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? theme.primaryColor : Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? theme.primaryColor : Colors.grey.shade600,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  color: isSelected ? theme.primaryColor : Colors.grey.shade700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (onClear != null)
              GestureDetector(
                onTap: onClear,
                child: Icon(
                  Icons.close_rounded,
                  size: 16,
                  color: theme.primaryColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Subject Card Widget
class _SubjectCard extends ConsumerWidget {
  final SubjectModel subject;
  final VoidCallback onDelete;

  const _SubjectCard({required this.subject, required this.onDelete});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // print("levels ===========> ${levelsData.map((e)=> e.toJson())}");
    final levelsState = ref.watch(levelsProvider);
    final theme = Theme.of(context);
    return levelsState.when(
      data: (levels) {
        final level = levels.firstWhere(
          (level) => level.classes!.any((c) => c.id == subject.classId),
        );

        final schoolClass = levels
            .expand((level) => level.classes!)
            .firstWhere((c) => c.id == subject.classId);

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.menu_book_rounded,
                        color: Colors.blue.shade600,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            subject.name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.school_rounded,
                            size: 14,
                            color: theme.primaryColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            level.name,
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.class_rounded,
                            size: 14,
                            color: Colors.blue.shade700,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            schoolClass.name,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      loading: () => Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.menu_book_rounded,
                  color: Colors.grey.shade400,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: 150,
                      color: Colors.grey.shade300,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      error: (err, stack) => Center(
        child: Text('${AppLocalizations.of(context)!.errorPrefix}$err'),
      ),
    );
  }
}

// Select Subject Flow - Step-by-step selection
class _SelectSubjectFlow extends ConsumerStatefulWidget {
  final Function(int levelId, int classId, AllSubjectsModel subject)
  onSubjectSelected;

  const _SelectSubjectFlow({required this.onSubjectSelected});

  @override
  ConsumerState<_SelectSubjectFlow> createState() => _SelectSubjectFlowState();
}

class _SelectSubjectFlowState extends ConsumerState<_SelectSubjectFlow> {
  int _currentStep = 0;
  int? _selectedLevelId;
  int? _selectedClassId;

  List<ClassModel> get availableClasses {
    final levelsState = ref.watch(levelsProvider);

    if (levelsState is AsyncData) {
      final levels = levelsState.value!;
      if (_selectedLevelId == null) return [];
      return levels.firstWhere((l) => l.id == _selectedLevelId).classes ?? [];
    }
    return [];
  }

  List<AllSubjectsModel> get availableSubjects {
    final levelsState = ref.watch(levelsProvider);

    if (levelsState is AsyncData) {
      final levels = levelsState.value!;
      if (_selectedLevelId == null || _selectedClassId == null) return [];
      final level = levels.firstWhere(
        (l) => l.id == _selectedLevelId,
        orElse: () => LevelModel(id: 0, name: '', classes: []),
      );
      final schoolClass = level.classes?.firstWhere(
        (c) => c.id == _selectedClassId,
        orElse: () => ClassModel(id: 0, name: '', levelId: 0, subjects: []),
      );
      return schoolClass?.subjects ?? [];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.addSubjectTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildStepIndicator(theme),
          Expanded(child: _buildCurrentStep(theme)),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(ThemeData theme) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Row(
        children: [
          _buildStepCircle(
            1,
            AppLocalizations.of(context)!.educationalLevel,
            _currentStep >= 0,
            theme,
          ),
          Expanded(child: _buildStepLine(_currentStep >= 1, theme)),
          _buildStepCircle(
            2,
            AppLocalizations.of(context)!.schoolClass,
            _currentStep >= 1,
            theme,
          ),
          Expanded(child: _buildStepLine(_currentStep >= 2, theme)),
          _buildStepCircle(
            3,
            AppLocalizations.of(context)!.subject,
            _currentStep >= 2,
            theme,
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle(
    int step,
    String label,
    bool isActive,
    ThemeData theme,
  ) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? theme.primaryColor : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
            color: isActive ? theme.primaryColor : Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(bool isActive, ThemeData theme) {
    return Container(
      height: 2,
      margin: const EdgeInsets.only(bottom: 28),
      color: isActive ? theme.primaryColor : Colors.grey.shade300,
    );
  }

  Widget _buildCurrentStep(ThemeData theme) {
    switch (_currentStep) {
      case 0:
        return _buildLevelSelection(theme);
      case 1:
        return _buildClassSelection(theme);
      case 2:
        return _buildSubjectSelection(theme);
      default:
        return const SizedBox();
    }
  }

  Widget _buildLevelSelection(ThemeData theme) {
    final levelsState = ref.watch(levelsProvider);

    return levelsState.when(
      data: (levels) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                AppLocalizations.of(context)!.selectLevel,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: levels.length,
                itemBuilder: (context, index) {
                  final level = levels[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedLevelId = level.id;
                          _currentStep = 1;
                        });
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.school_rounded,
                                color: theme.primaryColor,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                level.name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1E293B),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: Colors.grey.shade400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Text(
          '${AppLocalizations.of(context)!.errorOccurred}: ${err.toString()}',
        ),
      ),
    );
  }

  Widget _buildClassSelection(ThemeData theme) {
    final levelsState = ref.watch(levelsProvider);

    return levelsState.when(
      data: (levels) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                AppLocalizations.of(context)!.selectClass,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: availableClasses.length,
                itemBuilder: (context, index) {
                  final schoolClass = availableClasses[index];
                  final subjectCount = schoolClass.subjects?.length ?? 0;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedClassId = schoolClass.id;
                          _currentStep = 2;
                        });
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.class_rounded,
                                color: theme.primaryColor,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    schoolClass.name,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '$subjectCount ${AppLocalizations.of(context)!.subject}', // "مادة دراسية" -> subject
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: Colors.grey.shade400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Text(
          '${AppLocalizations.of(context)!.errorOccurred}: ${err.toString()}',
        ),
      ),
    );
  }

  Widget _buildSubjectSelection(ThemeData theme) {
    final levelsState = ref.watch(levelsProvider);

    return levelsState.when(
      data: (levels) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                AppLocalizations.of(context)!.selectSubject,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: availableSubjects.length,
                itemBuilder: (context, index) {
                  final subjectTemplate = availableSubjects[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () {
                        widget.onSubjectSelected(
                          _selectedLevelId!,
                          _selectedClassId!,
                          subjectTemplate,
                        );
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!.subjectAddedSuccess,
                            ),
                            backgroundColor: Colors.green,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.menu_book_rounded,
                                color: Colors.blue.shade600,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    subjectTemplate.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E293B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.add_circle_outline,
                              size: 24,
                              color: theme.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(
        child: Text(
          '${AppLocalizations.of(context)!.errorOccurred}: ${err.toString()}',
        ),
      ),
    );
  }
}
