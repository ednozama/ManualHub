import 'package:flutter/material.dart';

import '../models/history_entry.dart';

class HistoryCard extends StatelessWidget {
  final HistoryEntry entry;

  const HistoryCard({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.build),
        ),
        title: Text(entry.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(entry.description),
            const SizedBox(height: 4),
            Text(
              "${entry.date.day.toString().padLeft(2, '0')}."
              "${entry.date.month.toString().padLeft(2, '0')}."
              "${entry.date.year}",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}