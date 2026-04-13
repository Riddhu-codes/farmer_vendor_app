import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farmer_vendor_app/main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  /// 🌐 LANGUAGE DIALOG
  void showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text("Select Language"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              ListTile(
                title: const Text("English"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("English Selected")),
                  );
                },
              ),

              ListTile(
                title: const Text("Gujarati"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Gujarati Selected")),
                  );
                },
              ),

              ListTile(
                title: const Text("Hindi"),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Hindi Selected")),
                  );
                },
              ),

            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text("Settings"),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          /// 👤 PROFILE
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: ListTile(
              leading: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.green,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: const Text(
                "Farmer Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("farmer@email.com"),
              trailing: const Icon(Icons.edit),
            ),
          ),

          const SizedBox(height: 20),

          /// ⚙️ SETTINGS
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Column(
              children: [

                /// 🌙 DARK MODE
                SwitchListTile(
                  value: themeProvider.isDark,
                  activeColor: Colors.green,
                  title: const Text("Dark Mode"),
                  secondary: const Icon(Icons.dark_mode),
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),

                const Divider(),

                /// 🔔 NOTIFICATION
                SwitchListTile(
                  value: true,
                  activeColor: Colors.green,
                  title: const Text("Notifications"),
                  secondary: const Icon(Icons.notifications),
                  onChanged: (value) {},
                ),

                const Divider(),

                /// 🌐 LANGUAGE
                ListTile(
                  leading: const Icon(Icons.language),
                  title: const Text("Language"),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    showLanguageDialog(context); // 🔥 FIX
                  },
                ),

              ],
            ),
          ),

          const SizedBox(height: 20),

          /// 📞 HELP
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: Column(
              children: [

                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text("Help & Support"),
                ),

                const Divider(),

                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text("About App"),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// 🔴 LOGOUT
          SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text("Logout"),
                    content: const Text("Are you sure you want to logout?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text("Logout"),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}