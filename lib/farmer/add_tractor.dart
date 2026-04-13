import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddTractorPage extends StatefulWidget {
  const AddTractorPage({super.key});

  @override
  State<AddTractorPage> createState() => _AddTractorPageState();
}

class _AddTractorPageState extends State<AddTractorPage> {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final modelController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  String rentType = "Per Hour";

  File? imageFile;

  /// 📸 IMAGE PICK
  Future pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (picked != null) {
      setState(() {
        imageFile = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,

      appBar: AppBar(
        title: const Text("Add Tractor"),
        backgroundColor: Colors.green.shade700,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: _formKey,
          child: Column(
            children: [

              /// 📸 IMAGE
              GestureDetector(
                onTap: pickImage,
                child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.green.shade300),
                  ),
                  child: imageFile == null
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.camera_alt, size: 40, color: Colors.green),
                      SizedBox(height: 8),
                      Text("Tap to add tractor image"),
                    ],
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(imageFile!, fit: BoxFit.cover),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// 🔥 FORM CARD
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [

                      /// Tractor Name
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Tractor Name",
                          prefixIcon: const Icon(Icons.agriculture),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? "Enter tractor name" : null,
                      ),

                      const SizedBox(height: 15),

                      /// Model
                      TextFormField(
                        controller: modelController,
                        decoration: InputDecoration(
                          labelText: "Model",
                          prefixIcon: const Icon(Icons.precision_manufacturing),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? "Enter model" : null,
                      ),

                      const SizedBox(height: 15),

                      /// Rent Type
                      DropdownButtonFormField(
                        value: rentType,
                        decoration: InputDecoration(
                          labelText: "Rent Type",
                          prefixIcon: const Icon(Icons.timer),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: ["Per Hour", "Per Day", "Per Acre"]
                            .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            rentType = value.toString();
                          });
                        },
                      ),

                      const SizedBox(height: 15),

                      /// Price
                      TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Price",
                          prefixIcon: const Icon(Icons.currency_rupee),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? "Enter price" : null,
                      ),

                      const SizedBox(height: 15),

                      /// Location
                      TextFormField(
                        controller: locationController,
                        decoration: InputDecoration(
                          labelText: "Location",
                          prefixIcon: const Icon(Icons.location_on),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      /// Description
                      TextFormField(
                        controller: descriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: "Description",
                          prefixIcon: const Icon(Icons.notes),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25),

                      /// 🔥 ADD BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade700,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),

                          onPressed: () {
                            if (_formKey.currentState!.validate()) {

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Tractor Added Successfully"),
                                  duration: Duration(seconds: 1),
                                ),
                              );

                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pop(context);
                              });
                            }
                          },

                          child: const Text(
                            "Add Tractor",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
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