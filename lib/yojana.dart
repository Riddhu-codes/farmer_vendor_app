import 'package:flutter/material.dart';

class YojanaPage extends StatelessWidget {
  const YojanaPage({super.key}); // 👈 MUST

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yojana")),
      body: const Center(child: Text("Yojana Page")),
    );
  }
}