import 'package:flutter/material.dart';

import '../widgets/custom_dropdown.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/primary_button.dart';

class AddDeviceScreen extends StatefulWidget {
  const AddDeviceScreen({super.key});

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
  void dispose() {
    manufacturerController.dispose();
    modelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Neues Gerät"),
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
                    onTap: () {},

                    borderRadius: BorderRadius.circular(60),

                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white10,

                      child: Icon(
                        Icons.photo_camera,
                        size: 45,
                        color: Colors.grey.shade300,
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
              text: "Gerät speichern",
              icon: Icons.save,
              onPressed: () {

              },
            ),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}