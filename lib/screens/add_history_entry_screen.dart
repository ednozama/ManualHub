import 'package:flutter/material.dart';

import '../models/history_entry.dart';

class AddHistoryEntryScreen extends StatefulWidget {
  final HistoryEntry? entry;

  const AddHistoryEntryScreen({
    super.key,
    this.entry,
  });

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
void initState() {
  super.initState();

  if (widget.entry != null) {
    titleController.text = widget.entry!.title;
    descriptionController.text = widget.entry!.description;

    if (widget.entry!.costs != null) {
      costsController.text =
          widget.entry!.costs.toString();
    }

    selectedDate = widget.entry!.date;
  }
}

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

  if (widget.entry == null) {
    final entry = HistoryEntry(
      date: selectedDate,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      costs: costs,
    );

    Navigator.pop(context, entry);
  } else {
    widget.entry!.date = selectedDate;
    widget.entry!.title = titleController.text.trim();
    widget.entry!.description = descriptionController.text.trim();
    widget.entry!.costs = costs;

    Navigator.pop(context, widget.entry);
  }
}

Future<void> _pickDate() async {
  final picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    locale: const Locale('de', 'DE'),
  );

  if (picked == null) return;

  setState(() {
    selectedDate = picked;
  });
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

InkWell(
  onTap: _pickDate,
  borderRadius: BorderRadius.circular(12),
  child: InputDecorator(
    decoration: const InputDecoration(
      labelText: "Datum",
      border: OutlineInputBorder(),
      prefixIcon: Icon(Icons.calendar_month),
    ),
    child: Text(
  "${selectedDate.day.toString().padLeft(2, '0')}."
  "${selectedDate.month.toString().padLeft(2, '0')}."
  "${selectedDate.year}",
),
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