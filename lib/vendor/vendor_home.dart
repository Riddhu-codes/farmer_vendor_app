import 'package:flutter/material.dart';
import 'package:farmer_vendor_app/farmer/add_crop.dart';
import 'package:farmer_vendor_app/farmer/manage_orders.dart';
import 'package:farmer_vendor_app/farmer/farmer_home.dart';
import 'package:farmer_vendor_app/vendor/settings_page.dart';
import 'package:farmer_vendor_app/aaj_na_bhav.dart';
import 'package:farmer_vendor_app/yojana.dart';

class VendorHome extends StatefulWidget {
  const VendorHome({super.key});

  @override
  State<VendorHome> createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {

  int currentIndex = 0;

  final List<Widget> pages = [
    const VendorDashboard(),
    const PricePage(),
    const YojanaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      /// 🔻 FOOTER
      bottomNavigationBar: Container(
        color: Colors.grey.shade200,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            navItem("Vendor", 0),
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

/// 🔥 VENDOR DASHBOARD
class VendorDashboard extends StatelessWidget {
  const VendorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade600,

      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        title: const Text("Vendor Panel"),

        actions: [

          /// 🔄 SWITCH → Farmer
          IconButton(
            icon: const Icon(Icons.swap_horiz, color: Colors.yellow),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const FarmerHome(),
                ),
              );
            },
          ),

          /// 👤 PROFILE
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const VendorDashboard()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black),
              ),
            ),
          ),
        ],
      ),

      /// 🔲 GRID (UPDATED BUTTONS)
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: GridView.builder(
          itemCount: 6,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {

            final items = [
              ["Search Crop", Icons.search],
              ["My Orders", Icons.shopping_bag],
              ["Favorites", Icons.favorite],
              ["Dava", Icons.medical_services],
              ["Tractor", Icons.agriculture],
              ["Settings", Icons.settings],
            ];

            final pages = [
              const AddCropPage(),           // 🔁 change if needed
              const ManageOrders(),
              const DummyPage(title: "Favorites"),
              const DummyPage(title: "Dava"),
              const DummyPage(title: "Tractor"),
              const SettingsPage(),
            ];

            return buildBox(
              context,
              items[index][0] as String,
              items[index][1] as IconData,
              pages[index],
            );
          },
        ),
      ),
    );
  }

  Widget buildBox(BuildContext context, String text, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(2, 4),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 35, color: Colors.green.shade700),
            const SizedBox(height: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 👤 PROFILE
/*class VendorProfilePage extends StatelessWidget {
  const VendorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Vendor Profile")),
      body: Column(
        children: const [
          SizedBox(height: 30),
          CircleAvatar(radius: 50, child: Icon(Icons.person, size: 40)),
          SizedBox(height: 10),
          Text("Vendor Name", style: TextStyle(fontSize: 18)),
          Text("vendor@email.com"),
        ],
      ),
    );
  }
}*/

/// 🔧 DUMMY PAGE
class DummyPage extends StatelessWidget {
  final String title;
  const DummyPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}