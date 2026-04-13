import 'package:flutter/material.dart';

class PricePage extends StatelessWidget {
  const PricePage({super.key}); // 👈 MUST

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aaj Na Bhav")),
      body: const Center(child: Text("Bhav Page")),
    );
  }
}