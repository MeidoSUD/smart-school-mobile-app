import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:geniuses_school/presentation/widgets/common/ballsWidget.dart';
import 'package:flutter/material.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
        {};

    final String levelName = args["levelName"] ?? "Unknown Level";
    final String className = args["className"] ?? "Unknown Class";
    final List subjects = args["subjects"] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.subjectsOf(className)),
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
              // Breadcrumb
              _breadcrumb(context, [
                {"title": levelName, "route": "/levels-manage"},
                {"title": className, "route": "/classes-manage"},
              ], theme),
              const SizedBox(height: 8),

              // Subjects list
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ListView.builder(
                    itemCount: subjects.length,
                    itemBuilder: (context, index) {
                      final subject = subjects[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/lessons-manage',
                            arguments: {
                              "levelName": levelName,
                              "className": className,
                              "subject": subject,
                            },
                          );
                        },
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: theme.primaryColor.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.book,
                                      color: theme.primaryColor,
                                      size: 28,
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      subject,
                                      style: theme.textTheme.titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  Icons.arrow_forward,
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
        label: Text(l10n.addSubject),
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
                    Navigator.popUntil(context, (route) {
                      return route.settings.name == item["route"];
                    });
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
