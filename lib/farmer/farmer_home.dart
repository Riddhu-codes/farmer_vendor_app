import 'package:farmer_vendor_app/vendor/vendor_home.dart';
import 'package:flutter/material.dart';

// IMPORT PAGES
import 'add_crop.dart';
import 'dava_crop.dart';
import 'manage_orders.dart';
import 'my_crops_screen.dart';
import 'tractor_screen.dart';
import 'settings_screen.dart';
import 'package:farmer_vendor_app/aaj_na_bhav.dart';
import 'package:farmer_vendor_app/yojana.dart';
import 'add_dava.dart';
import 'add_tractor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const FarmerHome(),
    );
  }
}

class FarmerHome extends StatefulWidget {
  const FarmerHome({super.key});

  @override
  State<FarmerHome> createState() => _FarmerHomeState();
}

class _FarmerHomeState extends State<FarmerHome> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const FarmerDashboard(),
    const PricePage(),
    const YojanaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem("Farmer", 0),
            navItem("Bhav", 1),
            navItem("Yojana", 2),
          ],
        ),
      ),
    );
  }

  Widget navItem(String title, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: currentIndex == index ? Colors.green : Colors.black,
        ),
      ),
    );
  }
}

class FarmerDashboard extends StatelessWidget {
  const FarmerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade600,

      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text("Smart Farmer Panel"),

        actions: [

          /// 🔄 DIRECT SWITCH → VENDOR
          IconButton(
            icon: const Icon(Icons.swap_horiz, color: Color.fromARGB(255, 255, 229, 82)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const VendorHome()),
              );
            },
          ),

         /* /// 👤 PROFILE
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ProfilePage()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black),
              ),
            ),
          ),*/
        ],
      ),

      /// GRID
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: 8,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {

            final items = [
              ["Add Crop", Icons.add, const AddCropPage()],
              ["Orders", Icons.list_alt, const ManageOrders()],
              ["My Crops", Icons.grass, const MyCropsPage()],
              ["Dava", Icons.medical_services, const DavaPage()],
              ["Add Dava", Icons.add_circle, const AddDavaPage()],
              ["Add Tractor", Icons.add_box, const AddTractorPage()],
              ["Tractor", Icons.agriculture, const TractorScreen()],
              ["Settings", Icons.settings, const SettingsScreen()],
            ];

            return buildCard(
              context,
              items[index][0] as String,
              items[index][1] as IconData,
              items[index][2] as Widget,
            );
          },
        ),
      ),
    );
  }

  Widget buildCard(BuildContext context, String title, IconData icon, Widget page) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black12, blurRadius: 5)
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 35, color: Colors.green),
            const SizedBox(height: 10),
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}

/// 👤 PROFILE
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        children: const [
          SizedBox(height: 30),
          CircleAvatar(radius: 50, child: Icon(Icons.person, size: 40)),
          SizedBox(height: 10),
          Text("Farmer Name", style: TextStyle(fontSize: 18)),
          Text("farmer@email.com"),
        ],
      ),
    );
  }
}