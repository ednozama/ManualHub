import 'package:flutter/material.dart';

import '../widgets/custom_dropdown.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/primary_button.dart';
import '../models/device.dart';
import '../services/storage_service.dart';
import 'dart:io';
import '../services/image_service.dart';

class AddDeviceScreen extends StatefulWidget {
  final Device? device;

  const AddDeviceScreen({
    super.key,
    this.device,
  });

  @override
  State<AddDeviceScreen> createState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends State<AddDeviceScreen> {

  final TextEditingController manufacturerController =
      TextEditingController();

  final TextEditingController modelController =
      TextEditingController();

  String? selectedCategory;
  String? selectedLocation;
  String? imagePath;
  String? manualPath;

  final List<String> categories = [
    "Fernseher",
    "Kaffeemaschine",
    "Waschmaschine",
    "Kühlschrank",
    "Backofen",
    "Smartphone",
    "Laptop",
    "Drucker",
    "Router",
    "Werkzeug",
    "Sonstiges",
  ];

  final List<String> locations = [
    "Wohnzimmer",
    "Küche",
    "Schlafzimmer",
    "Büro",
    "Garage",
    "Keller",
    "Garten",
    "Sonstiges",
  ];

  @override
void initState() {
  super.initState();

  if (widget.device != null) {
    manufacturerController.text = widget.device!.manufacturer;
    modelController.text = widget.device!.model;

    selectedCategory = widget.device!.category;
    selectedLocation = widget.device!.location;
    imagePath = widget.device!.imagePath;
    manualPath = widget.device!.manualPath;
  }
}

  @override
  void dispose() {
    manufacturerController.dispose();
    modelController.dispose();
    super.dispose();
  }

  Future<void> _saveDevice() async {
  if (manufacturerController.text.trim().isEmpty ||
      modelController.text.trim().isEmpty ||
      selectedCategory == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Bitte Hersteller, Modell und Kategorie ausfüllen.',
        ),
      ),
    );
    return;
  }

  if (widget.device == null) {
    // Neues Gerät anlegen
    final device = Device(
      manufacturer: manufacturerController.text.trim(),
      model: modelController.text.trim(),
      category: selectedCategory!,
      location: selectedLocation ?? "",
      imagePath: imagePath,
      manualPath: manualPath,
    );

    await StorageService.addDevice(device);
  } else {
    // Bestehendes Gerät bearbeiten
    widget.device!.manufacturer = manufacturerController.text.trim();
    widget.device!.model = modelController.text.trim();
    widget.device!.category = selectedCategory!;
    widget.device!.location = selectedLocation ?? "";
    widget.device!.imagePath = imagePath;
    widget.device!.manualPath = manualPath;

    await widget.device!.save();
  }

  if (!mounted) return;

  Navigator.pop(context);
}

Future<void> _selectImage() async {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: const Text("Foto aufnehmen"),
              onTap: () async {
                Navigator.pop(context);

                final path =
                    await ImageService.pickImageFromCamera();

                if (path != null) {
                  setState(() {
                    imagePath = path;
                  });
                }
              },
            ),

            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Aus Galerie auswählen"),
              onTap: () async {
                Navigator.pop(context);

                final path =
                    await ImageService.pickImageFromGallery();

                if (path != null) {
                  setState(() {
                    imagePath = path;
                  });
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(
  widget.device == null
      ? "Neues Gerät"
      : "Gerät bearbeiten",
),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 10),

            Center(
              child: Column(
                children: [

                  InkWell(
                    onTap: _selectImage,

                    borderRadius: BorderRadius.circular(60),

                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white10,

                      child: imagePath == null
    ? Icon(
        Icons.photo_camera,
        size: 45,
        color: Colors.grey.shade300,
      )
    : ClipOval(
        child: Image.file(
          File(imagePath!),
          width: 110,
          height: 110,
          fit: BoxFit.cover,
        ),
      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Gerätefoto hinzufügen",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            CustomTextField(
              label: "Hersteller",
              hint: "z.B. Bosch",
              icon: Icons.business,
              controller: manufacturerController,
            ),

            const SizedBox(height: 25),

            CustomTextField(
              label: "Modell",
              hint: "z.B. SMS6ZCI49E",
              icon: Icons.devices,
              controller: modelController,
            ),

            const SizedBox(height: 25),

            CustomDropdown(
              label: "Kategorie",
              icon: Icons.category,
              value: selectedCategory,
              items: categories,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),

            const SizedBox(height: 25),

            CustomDropdown(
              label: "Standort",
              icon: Icons.location_on,
              value: selectedLocation,
              items: locations,
              onChanged: (value) {
                setState(() {
                  selectedLocation = value;
                });
              },
            ),

            const SizedBox(height: 40),

            PrimaryButton(
  text: widget.device == null
      ? "Gerät speichern"
      : "Änderungen speichern",
  icon: Icons.save,
  onPressed: _saveDevice,
),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}