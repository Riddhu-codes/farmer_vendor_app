import 'package:flutter/material.dart';

class DavaPage extends StatefulWidget {
  const DavaPage({super.key});

  @override
  State<DavaPage> createState() => _DavaPageState();
}

class _DavaPageState extends State<DavaPage> {

  List<Map<String, String>> davaList = [
    {"name": "Urea", "use": "Fertilizer"},
    {"name": "DAP", "use": "Crop Growth"},
    {"name": "Pesticide X", "use": "Insect Control"},
  ];

  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dava (Medicine)"),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          showAddDialog();
        },
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// 🔍 Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search Dava...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ),

            const SizedBox(height: 15),

            /// 📋 List
            Expanded(
              child: ListView(
                children: davaList
                    .where((dava) =>
                        dava["name"]!.toLowerCase().contains(searchText))
                    .map((dava) => Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 3,
                          child: ListTile(
                            leading: const Icon(Icons.medical_services,
                                color: Colors.green),
                            title: Text(dava["name"]!),
                            subtitle: Text(dava["use"]!),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ➕ Add Dava Dialog
  void showAddDialog() {
    TextEditingController nameController = TextEditingController();
    TextEditingController useController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add Dava"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Dava Name"),
            ),
            TextField(
              controller: useController,
              decoration: const InputDecoration(labelText: "Use"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                davaList.add({
                  "name": nameController.text,
                  "use": useController.text
                });
              });
              Navigator.pop(context);
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }
}