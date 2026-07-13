import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'add_device_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,

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

              const SizedBox(height: 30),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),

                  child: Column(
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
                        "Verwalte Bedienungsanleitungen,\nRechnungen und Garantien an einem Ort.",
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,

                        child: ElevatedButton.icon(
                          onPressed: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const AddDeviceScreen(),
    ),
  );
},

                          icon: const Icon(Icons.add),

                          label: const Text(
                            "Neues Gerät hinzufügen",
                          ),
                        ),
                      ),
                    ],
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