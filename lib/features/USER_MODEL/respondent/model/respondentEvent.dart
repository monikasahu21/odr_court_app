import 'package:flutter/material.dart';

class EventModel {
  final String title;
  final String description;
  final String date;
  final IconData icon;

  EventModel({
    required this.title,
    required this.description,
    required this.date,
    required this.icon,
  });

  /// Safe factory from dynamic map (handles nulls and wrong types)
  factory EventModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) {
      return EventModel(
        title: 'Untitled Event',
        description: 'No description available',
        date: 'Unknown date',
        icon: Icons.event,
      );
    }

    final title = (map['title'] ?? 'Untitled Event').toString();
    final description =
        (map['description'] ?? 'No description available').toString();
    final date = (map['date'] ?? 'Unknown date').toString();
    final icon =
        (map['icon'] is IconData) ? map['icon'] as IconData : Icons.event;

    return EventModel(
      title: title,
      description: description,
      date: date,
      icon: icon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
      // We don't serialize IconData here; keep it in memory for UI
    };
  }
}
