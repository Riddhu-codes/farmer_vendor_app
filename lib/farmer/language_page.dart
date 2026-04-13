import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farmer_vendor_app/language_provider.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {

  String selected = "English";

  @override
  void initState() {
    super.initState();

    final locale =
        Provider.of<LanguageProvider>(context, listen: false).locale;

    if (locale.languageCode == 'gu') {
      selected = "Gujarati";
    } else if (locale.languageCode == 'hi') {
      selected = "Hindi";
    } else {
      selected = "English";
    }
  }

  void changeLanguage(String value) {
    setState(() {
      selected = value;
    });

    String code = 'en';

    if (value == "Gujarati") code = 'gu';
    if (value == "Hindi") code = 'hi';

    Provider.of<LanguageProvider>(context, listen: false)
        .changeLanguage(code);

    /// 🔥 optional message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$value Selected")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,

      appBar: AppBar(
        title: const Text("Language"),
        backgroundColor: Colors.green.shade700,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [

              const SizedBox(height: 10),

              /// 🇬🇧 ENGLISH
              RadioListTile(
                value: "English",
                groupValue: selected,
                title: const Text("English"),
                secondary: const Icon(Icons.language),
                onChanged: (val) {
                  changeLanguage(val.toString());
                },
              ),

              const Divider(),

              /// 🇮🇳 GUJARATI
              RadioListTile(
                value: "Gujarati",
                groupValue: selected,
                title: const Text("Gujarati"),
                secondary: const Icon(Icons.translate),
                onChanged: (val) {
                  changeLanguage(val.toString());
                },
              ),

              const Divider(),

              /// 🇮🇳 HINDI
              RadioListTile(
                value: "Hindi",
                groupValue: selected,
                title: const Text("Hindi"),
                secondary: const Icon(Icons.g_translate),
                onChanged: (val) {
                  changeLanguage(val.toString());
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}