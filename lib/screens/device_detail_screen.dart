import 'package:flutter/material.dart';

import '../models/device.dart';
import 'add_device_screen.dart';

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

            const CircleAvatar(
              radius: 55,
              child: Icon(
                Icons.devices,
                size: 45,
              ),
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