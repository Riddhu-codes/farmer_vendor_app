import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final String role;
  final String? oldName;
  final File? oldImage;

  const ProfileScreen({
    super.key,
    required this.role,
    this.oldName,
    this.oldImage,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  File? image;
  final name = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.text = widget.oldName ?? "";
    image = widget.oldImage;
  }

  void pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => image = File(picked.path));
    }
  }

  void saveProfile() {
    Navigator.pop(context, {
      "name": name.text,
      "image": image,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text("Profile")),

      body: Column(
        children: [

          const SizedBox(height: 20),

          GestureDetector(
            onTap: pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: image != null ? FileImage(image!) : null,
              child: image == null
                  ? const Icon(Icons.camera_alt)
                  : null,
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: name,
              decoration: const InputDecoration(
                hintText: "Enter Name",
                border: OutlineInputBorder(),
              ),
            ),
          ),

          ElevatedButton(
            onPressed: saveProfile,
            child: const Text("Save"),
          )
        ],
      ),
    );
  }
}