import 'package:flutter/material.dart';
import 'dart:io';
import '../models/device.dart';
import 'add_device_screen.dart';
import '../services/pdf_service.dart';

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

  Future<void> _selectManual() async {
  final path = await PdfService.pickPdf();

  if (path == null) return;

  widget.device.manualPath = path;
  await widget.device.save();

  if (!mounted) return;

  setState(() {});
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

            const SizedBox(height: 12),

Card(
  child: ListTile(
    leading: const Icon(Icons.picture_as_pdf),
    title: const Text("Bedienungsanleitung"),
    subtitle: Text(
      widget.device.manualPath == null
          ? "Keine Bedienungsanleitung vorhanden"
          : "Bedienungsanleitung gespeichert",
    ),
    trailing: const Icon(Icons.chevron_right),
    onTap: _selectManual,
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