import 'package:geniuses_school/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

enum RequestStatus { pending, urgent, accepted, completed }

class StatusConfig {
  final String label;
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color dotColor;

  StatusConfig({
    required this.label,
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.dotColor,
  });
}

extension RequestStatusExtension on RequestStatus {
  StatusConfig getConfig(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case RequestStatus.pending:
        return StatusConfig(
          label: l10n.statusPending,
          backgroundColor: Colors.amber.shade50,
          borderColor: Colors.amber.shade200,
          textColor: Colors.amber.shade800,
          dotColor: Colors.amber.shade600,
        );
      case RequestStatus.urgent:
        return StatusConfig(
          label: l10n.statusUrgent,
          backgroundColor: Colors.red.shade50,
          borderColor: Colors.red.shade200,
          textColor: Colors.red.shade800,
          dotColor: Colors.red.shade600,
        );
      case RequestStatus.accepted:
        return StatusConfig(
          label: l10n.statusAccepted,
          backgroundColor: Colors.green.shade50,
          borderColor: Colors.green.shade200,
          textColor: Colors.green.shade800,
          dotColor: Colors.green.shade600,
        );
      case RequestStatus.completed:
        return StatusConfig(
          label: l10n.statusCompleted,
          backgroundColor: Colors.blue.shade50,
          borderColor: Colors.blue.shade200,
          textColor: Colors.blue.shade800,
          dotColor: Colors.blue.shade600,
        );
    }
  }
}

class OrderRequest {
  final String id;
  final String subject;
  final String studentName;
  final String date;
  final String description;
  final String price;
  final RequestStatus status;
  final String level;
  final String lessonType;

  OrderRequest({
    required this.id,
    required this.subject,
    required this.studentName,
    required this.date,
    required this.description,
    required this.price,
    required this.status,
    required this.level,
    required this.lessonType,
  });

  OrderRequest copyWith({
    String? id,
    String? subject,
    String? studentName,
    String? date,
    String? description,
    String? price,
    RequestStatus? status,
    String? level,
    String? lessonType,
  }) {
    return OrderRequest(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      studentName: studentName ?? this.studentName,
      date: date ?? this.date,
      description: description ?? this.description,
      price: price ?? this.price,
      status: status ?? this.status,
      level: level ?? this.level,
      lessonType: lessonType ?? this.lessonType,
    );
  }
}
