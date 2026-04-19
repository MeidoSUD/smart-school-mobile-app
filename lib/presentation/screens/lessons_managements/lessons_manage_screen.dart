import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/widgets/common/ballsWidget.dart';
import 'package:flutter/material.dart';

class LessonsManageScreen extends StatelessWidget {
  const LessonsManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
        {};
    final String levelName = args["levelName"] ?? "Unknown Level";
    final String className = args["className"] ?? "Unknown Class";
    final String subject = args["subject"] ?? "Unknown Subject";

    // Example: You could fetch actual lessons here
    final List lessons = []; // empty for now

    return Scaffold(
      appBar: AppBar(
        title: Text("$subject ${l10n.lessonsTitle}"),
        foregroundColor: Colors.white,
        backgroundColor: theme.primaryColor,
      ),
      body: Stack(
        children: [
          BallsWidget(
            size: 100,
            alignment: const Alignment(-1.2, -1.0),
            opacity: 0.2,
            color: theme.primaryColor,
          ),
          BallsWidget(
            size: 100,
            alignment: const Alignment(1.2, 0.2),
            opacity: 0.2,
            color: theme.primaryColor,
          ),
          BallsWidget(
            size: 100,
            alignment: const Alignment(-1.2, 0.9),
            opacity: 0.2,
            color: theme.primaryColor,
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _breadcrumb(context, [
                {"title": levelName, "route": "/levels-manage"},
                {"title": className, "route": "/classes-manage"},
                {"title": subject, "route": "/subjects-manage"},
              ], theme),
              const SizedBox(height: 16),
              Expanded(
                child: lessons.isEmpty
                    ? Center(
                        child: Text(
                          "${l10n.noLessonsForSubject} $subject.",
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: Colors.black54,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ListView.builder(
                          itemCount: lessons.length,
                          itemBuilder: (context, index) {
                            final lesson = lessons[index];
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                leading: Icon(
                                  Icons.menu_book,
                                  color: theme.primaryColor,
                                ),
                                title: Text(lesson['title']),
                                trailing: Icon(
                                  Icons.arrow_forward,
                                  color: theme.primaryColor,
                                ),
                                onTap: () {
                                  // TODO: Open lesson details
                                },
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Add new lesson
        },
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text(l10n.addLesson),
      ),
    );
  }

  Widget _breadcrumb(
    BuildContext context,
    List<Map<String, String>> items,
    ThemeData theme,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isLast = index == items.length - 1;
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  if (!isLast) {
                    final stepsToPop = items.length - 1 - index;
                    for (int i = 0; i < stepsToPop; i++) {
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text(
                  item["title"]!,
                  style: TextStyle(
                    color: isLast ? Colors.black : theme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (!isLast) const Text(" > "),
            ],
          );
        }),
      ),
    );
  }
}
