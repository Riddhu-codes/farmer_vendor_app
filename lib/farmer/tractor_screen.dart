import 'package:flutter/material.dart';

class TractorScreen extends StatelessWidget {
  const TractorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tractor")),
      body: const Center(child: Text("Tractor Page 🚜")),
    );
  }
}