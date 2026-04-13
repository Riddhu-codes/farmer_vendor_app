import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // ✅ FIX

import 'splash_screen.dart';
import 'providers/user_provider.dart';
import 'language_provider.dart';

/// 🔥 THEME PROVIDER
class ThemeProvider with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  ThemeMode get themeMode =>
      _isDark ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(bool value) {
    _isDark = value;
    notifyListeners();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],

      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, langProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            /// 🌐 LANGUAGE
            locale: langProvider.locale,

            supportedLocales: const [
              Locale('en'),
              Locale('gu'),
              Locale('hi'),
            ],

            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            /// ☀️ LIGHT
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.green,
            ),

            /// 🌙 DARK
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.green,
            ),

            /// 🔥 SWITCH
            themeMode: themeProvider.themeMode,

            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}