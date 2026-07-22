import 'package:flutter/material.dart';
import 'dart:io';
import '../models/device.dart';
import 'add_device_screen.dart';
import '../services/pdf_service.dart';
import 'package:open_filex/open_filex.dart';
import '../widgets/document_card.dart';
import '../models/document_type.dart';
import '../widgets/history_card.dart';
import 'add_history_entry_screen.dart';
import '../models/history_entry.dart';
import 'history_detail_screen.dart';

class DeviceDetailScreen extends StatefulWidget {
  final Device device;

  const DeviceDetailScreen({
    super.key,
    required this.device,
  });

  @override
  State<DeviceDetailScreen> createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  Future<void> _editDevice() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddDeviceScreen(
          device: widget.device,
        ),
      ),
    );

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _addHistoryEntry() async {
  final entry = await Navigator.push<HistoryEntry>(
    context,
    MaterialPageRoute(
      builder: (_) => const AddHistoryEntryScreen(),
    ),
  );

  if (entry == null) return;

  widget.device.history.insert(0, entry);

  await widget.device.save();

  if (!mounted) return;

  setState(() {});
}

String? _getDocumentPath(DocumentType type) {
  switch (type) {
    case DocumentType.manual:
      return widget.device.manualPath;

    case DocumentType.invoice:
      return widget.device.invoicePath;

    case DocumentType.warranty:
      return widget.device.warrantyPath;
  }
}

void _setDocumentPath(DocumentType type, String? path) {
  switch (type) {
    case DocumentType.manual:
      widget.device.manualPath = path;
      break;

    case DocumentType.invoice:
      widget.device.invoicePath = path;
      break;

    case DocumentType.warranty:
      widget.device.warrantyPath = path;
      break;
  }
}

String _getDocumentTitle(DocumentType type) {
  switch (type) {
    case DocumentType.manual:
      return "Bedienungsanleitung";

    case DocumentType.invoice:
      return "Rechnung";

    case DocumentType.warranty:
      return "Garantie";
  }
}
  Future<void> _documentAction(DocumentType type) async {
  final currentPath = _getDocumentPath(type);

  // Noch kein Dokument vorhanden
  if (currentPath == null) {
    final path = await PdfService.pickPdf();

    if (path == null) return;

    _setDocumentPath(type, path);
    await widget.device.save();

    if (!mounted) return;

    setState(() {});
    return;
  }

  // Dokument vorhanden
  showModalBottomSheet(
    context: context,
    builder: (_) => SafeArea(
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.open_in_new),
            title: Text("${_getDocumentTitle(type)} öffnen"),
            onTap: () async {
              Navigator.pop(context);
              await OpenFilex.open(currentPath);
            },
          ),

          ListTile(
            leading: const Icon(Icons.refresh),
            title: Text("${_getDocumentTitle(type)} ersetzen"),
            onTap: () async {
              Navigator.pop(context);

              final path = await PdfService.pickPdf();

              if (path == null) return;

              _setDocumentPath(type, path);
              await widget.device.save();

              if (!mounted) return;

              setState(() {});
            },
          ),

          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: Text(
              "${_getDocumentTitle(type)} entfernen",
            ),
            onTap: () async {
              Navigator.pop(context);

              _setDocumentPath(type, null);
              await widget.device.save();

              if (!mounted) return;

              setState(() {});
            },
          ),
        ],
      ),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gerät"),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [

            const SizedBox(height: 20),

            CircleAvatar(
  radius: 55,
  backgroundColor: Colors.white10,
  backgroundImage: widget.device.imagePath != null
      ? FileImage(File(widget.device.imagePath!))
      : null,
  child: widget.device.imagePath == null
      ? const Icon(
          Icons.devices,
          size: 45,
        )
      : null,
),

            const SizedBox(height: 20),

            Text(
              widget.device.manufacturer,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              widget.device.model,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 30),

Align(
  alignment: Alignment.centerLeft,
  child: Text(
    "Dokumente",
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 12),

DocumentCard(
  icon: Icons.picture_as_pdf,
  title: "Bedienungsanleitung",
  subtitle: widget.device.manualPath == null
      ? "Keine Bedienungsanleitung vorhanden"
      : PdfService.getDisplayName(widget.device.manualPath),
  onTap: () => _documentAction(DocumentType.manual),
),

DocumentCard(
  icon: Icons.receipt_long,
  title: "Rechnung",
  subtitle: widget.device.invoicePath == null
    ? "Keine Rechnung vorhanden"
    : PdfService.getDisplayName(widget.device.invoicePath),
  onTap: () => _documentAction(DocumentType.invoice),
),

DocumentCard(
  icon: Icons.verified_user,
  title: "Garantie",
  subtitle: widget.device.warrantyPath == null
    ? "Keine Garantie vorhanden"
    : PdfService.getDisplayName(widget.device.warrantyPath),
  onTap: () => _documentAction(DocumentType.warranty),
),
const SizedBox(height: 30),

Align(
  alignment: Alignment.centerLeft,
  child: Text(
    "Geräteinformationen",
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 12),

            Card(
              child: ListTile(
                leading: const Icon(Icons.category),
                title: const Text("Kategorie"),
                subtitle: Text(widget.device.category),
              ),
            ),

            Card(
              child: ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text("Standort"),
                subtitle: Text(
                  widget.device.location.isEmpty
                      ? "Nicht angegeben"
                      : widget.device.location,
                ),
              ),
            ),

            const SizedBox(height: 30),

Align(
  alignment: Alignment.centerLeft,
  child: Text(
    "Gerätehistorie",
    style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  ),
),

const SizedBox(height: 12),

if (widget.device.history.isEmpty)
  Card(
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          "Noch keine Historieneinträge vorhanden",
        ),
      ),
    ),
  )
else
  ...widget.device.history.map(
  (entry) => HistoryCard(
    entry: entry,
    onTap: () async {

  final result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => HistoryDetailScreen(
        entry: entry,
      ),
    ),
  );

  if (result == true) {
    widget.device.history.remove(entry);
    await widget.device.save();
  } else if (result is HistoryEntry) {
    final index = widget.device.history.indexOf(entry);

    if (index != -1) {
      widget.device.history[index] = result;
      await widget.device.save();
    }
  }

  if (!mounted) return;

  setState(() {});
},
  ),
),

const SizedBox(height: 12),

SizedBox(
  width: double.infinity,
  child: OutlinedButton.icon(
    onPressed: _addHistoryEntry,
    icon: Icon(Icons.add),
    label: Text("Historieneintrag hinzufügen"),
  ),
),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _editDevice,
                icon: const Icon(Icons.edit),
                label: const Text("Gerät bearbeiten"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}