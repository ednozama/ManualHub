import 'package:flutter/material.dart';

import '../models/device.dart';
import '../theme/app_theme.dart';

class DeviceCard extends StatelessWidget {
  final Device device;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const DeviceCard({
    super.key,
    required this.device,
    required this.onDelete,
    required this.onTap,
  });

  IconData _categoryIcon() {
    switch (device.category) {
      case "Fernseher":
        return Icons.tv;
      case "Kaffeemaschine":
        return Icons.coffee;
      case "Waschmaschine":
        return Icons.local_laundry_service;
      case "Kühlschrank":
        return Icons.kitchen;
      case "Laptop":
        return Icons.laptop;
      case "Smartphone":
        return Icons.smartphone;
      default:
        return Icons.devices;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),

      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Row(
            children: [

              CircleAvatar(
                radius: 28,
                backgroundColor: AppTheme.primary,

                child: Icon(
                  _categoryIcon(),
                  color: Colors.white,
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      device.manufacturer,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(device.model),

                    const SizedBox(height: 8),

                    Row(
                      children: [

                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey,
                        ),

                        const SizedBox(width: 4),

                        Expanded(
                          child: Text(
                            device.location.isEmpty
                                ? "Kein Standort"
                                : device.location,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              IconButton(
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}