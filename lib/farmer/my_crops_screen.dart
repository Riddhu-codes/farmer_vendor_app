import 'package:flutter/material.dart';

class MyCropsPage extends StatelessWidget {
  const MyCropsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Crops")),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.grass),
            title: Text("Wheat"),
            subtitle: Text("100 kg"),
          ),
          ListTile(
            leading: Icon(Icons.grass),
            title: Text("Rice"),
            subtitle: Text("200 kg"),
          ),
        ],
      ),
    );
  }
}