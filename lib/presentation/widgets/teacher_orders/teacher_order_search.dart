import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class TeacherOrderSearch extends StatelessWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;

  const TeacherOrderSearch({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Using a text controller to sync with the provided query might be tricky if parent updates it.
    // But here we can just use the value in the controller or assume it's one-way mainly.
    // However, if we want the clear button to work and update the text field, we should probably use a controller
    // that we initialize with the initial value, or simply rebuild the widget.
    // Stateless widget with fresh controller on rebuild is bad for typing focus.
    // So let's use a standard TextField. To allow 'clear' to work, we need a controller.
    // We can just trust the parent passes the state, but TextField needs a controller to be cleared programmatically.

    return _SearchField(
      searchQuery: searchQuery,
      onSearchChanged: onSearchChanged,
      theme: theme,
    );
  }
}

class _SearchField extends StatefulWidget {
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final ThemeData theme;

  const _SearchField({
    required this.searchQuery,
    required this.onSearchChanged,
    required this.theme,
  });

  @override
  State<_SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<_SearchField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.searchQuery);
  }

  @override
  void didUpdateWidget(_SearchField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.searchQuery != _controller.text) {
      // Only update if different to avoid cursor jumping if we were typing?
      // If parent updates it (e.g. clear filters), we need to update controller.
      // If user types, parent updates `searchQuery`, which matches `_controller.text`, so no internal change needed.
      _controller.text = widget.searchQuery;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: widget.theme.primaryColor,
        boxShadow: [
          BoxShadow(
            color: widget.theme.primaryColor.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          controller: _controller,
          onChanged: widget.onSearchChanged,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.searchOrdersHint,
            prefixIcon: Icon(Icons.search, color: widget.theme.primaryColor),
            suffixIcon: widget.searchQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      widget.onSearchChanged('');
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      ),
    );
  }
}
