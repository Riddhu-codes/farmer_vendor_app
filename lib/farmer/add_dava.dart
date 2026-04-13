import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddDavaPage extends StatefulWidget {
  const AddDavaPage({super.key});

  @override
  State<AddDavaPage> createState() => _AddDavaPageState();
}

class _AddDavaPageState extends State<AddDavaPage> {

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final useController = TextEditingController();
  final priceController = TextEditingController();
  final companyController = TextEditingController();

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
        title: const Text("Add Dava"),
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
                      Text("Tap to add dava image"),
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

                      /// Dava Name
                      TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Dava Name",
                          prefixIcon: const Icon(Icons.medical_services),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? "Enter dava name" : null,
                      ),

                      const SizedBox(height: 15),

                      /// Use
                      TextFormField(
                        controller: useController,
                        decoration: InputDecoration(
                          labelText: "Use / Purpose",
                          prefixIcon: const Icon(Icons.info),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) =>
                        value!.isEmpty ? "Enter use" : null,
                      ),

                      const SizedBox(height: 15),

                      /// Company
                      TextFormField(
                        controller: companyController,
                        decoration: InputDecoration(
                          labelText: "Company Name",
                          prefixIcon: const Icon(Icons.business),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
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
                                  content: Text("Dava Added Successfully"),
                                  duration: Duration(seconds: 1),
                                ),
                              );

                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pop(context);
                              });
                            }
                          },

                          child: const Text(
                            "Add Dava",
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