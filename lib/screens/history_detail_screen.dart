import 'package:flutter/material.dart';

import '../models/history_entry.dart';
import 'add_history_entry_screen.dart';
import '../widgets/app_page.dart';

class HistoryDetailScreen extends StatefulWidget {
  final HistoryEntry entry;

  const HistoryDetailScreen({
    super.key,
    required this.entry,
  });

  @override
  State<HistoryDetailScreen> createState() =>
      _HistoryDetailScreenState();
}

class _HistoryDetailScreenState
    extends State<HistoryDetailScreen> {

  Future<void> _editEntry() async {
  final updatedEntry = await Navigator.push<HistoryEntry>(
    context,
    MaterialPageRoute(
      builder: (_) => AddHistoryEntryScreen(
        entry: widget.entry,
      ),
    ),
  );

  if (updatedEntry == null) return;

  if (!mounted) return;

  Navigator.pop(context, updatedEntry);
}

  Future<void> _deleteEntry() async {
  final delete = await showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Historieneintrag löschen"),
      content: const Text(
        "Soll dieser Historieneintrag wirklich gelöscht werden?",
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Abbrechen"),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Löschen"),
        ),
      ],
    ),
  );

  if (delete != true) return;

  if (!mounted) return;

  Navigator.pop(context, true);
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Historieneintrag"),
      ),

      body: AppPage(
  child: SingleChildScrollView(
    padding: const EdgeInsets.all(20),

    child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              widget.entry.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Card(
              child: ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text("Datum"),
                subtitle: Text(
                  "${widget.entry.date.day.toString().padLeft(2, '0')}."
                  "${widget.entry.date.month.toString().padLeft(2, '0')}."
                  "${widget.entry.date.year}",
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.description),
                title: const Text("Beschreibung"),
                subtitle: Text(
                  widget.entry.description.isEmpty
                      ? "Keine Beschreibung"
                      : widget.entry.description,
                ),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.euro),
                title: const Text("Kosten"),
                subtitle: Text(
                  widget.entry.costs == null
                      ? "Keine Kosten"
                      : "${widget.entry.costs!.toStringAsFixed(2)} €",
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: _editEntry,
                icon: const Icon(Icons.edit),
                label: const Text("Historieneintrag bearbeiten"),
              ),
            ),
            
const SizedBox(height: 15),

SizedBox(
  width: double.infinity,
  child: OutlinedButton.icon(
    onPressed: _deleteEntry,
    icon: const Icon(
      Icons.delete,
      color: Colors.red,
    ),
    label: const Text(
      "Historieneintrag löschen",
      style: TextStyle(
        color: Colors.red,
      ),
    ),
  ),
),
          ],
        ),
      ),
      ),
    );
  }
}