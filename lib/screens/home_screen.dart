import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/device.dart';
import '../services/storage_service.dart';
import '../theme/app_theme.dart';
import 'add_device_screen.dart';
import '../widgets/device_card.dart';
import 'device_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Gerät hinzufügen"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddDeviceScreen(),
            ),
          );
        },
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 10),

              const Text(
                "📘 Manual Hub",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Dein digitales Gerätearchiv",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 30),

              TextField(
                decoration: InputDecoration(
                  hintText: "Geräte suchen...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: AppTheme.card,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: ValueListenableBuilder<Box<Device>>(
                  valueListenable: StorageService.listenToDevices(),

                  builder: (context, box, child) {

                    if (box.isEmpty) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(20),

                          child: Column(
                            mainAxisSize: MainAxisSize.min,

                            children: [

                              const Icon(
                                Icons.devices_other,
                                size: 60,
                                color: AppTheme.primary,
                              ),

                              const SizedBox(height: 15),

                              const Text(
                                "Noch keine Geräte vorhanden",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              const Text(
                                "Tippe unten auf 'Gerät hinzufügen', um dein erstes Gerät anzulegen.",
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: box.length,

                      itemBuilder: (context, index) {

                        final device = box.getAt(index)!;

                        return DeviceCard(
  device: device,

  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DeviceDetailScreen(
          device: device,
        ),
      ),
    );
  },

  onDelete: () async {
    await StorageService.deleteDevice(index);
  },
);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}