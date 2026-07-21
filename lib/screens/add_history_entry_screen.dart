import 'package:flutter/material.dart';

import '../models/history_entry.dart';

class AddHistoryEntryScreen extends StatefulWidget {
  const AddHistoryEntryScreen({super.key});

  @override
  State<AddHistoryEntryScreen> createState() =>
      _AddHistoryEntryScreenState();
}

class _AddHistoryEntryScreenState
    extends State<AddHistoryEntryScreen> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final costsController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    costsController.dispose();
    super.dispose();
  }

  Future<void> _save() async {

    if (titleController.text.trim().isEmpty) {
      return;
    }

    final costs = double.tryParse(
      costsController.text.replaceAll(",", "."),
    );

    final entry = HistoryEntry(
      date: selectedDate,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      costs: costs,
    );

    Navigator.pop(context, entry);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Historieneintrag"),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Titel",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: "Beschreibung",
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: costsController,
              keyboardType:
                  const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: "Kosten (optional)",
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.save),
                label: const Text(
                  "Historieneintrag speichern",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}