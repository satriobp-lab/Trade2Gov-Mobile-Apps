import 'package:flutter/material.dart';
import 'ui/landing/landing_page.dart';
import 'ui/splash/app_loader_page.dart';
import 'data/securestorage/secure_storage_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _getStartPage() async {
    final storage = SecureStorageService();
    final isLoggedIn = await storage.isLoggedIn();

    if (isLoggedIn) {
      return const AppLoaderPage(); // 👈 penting
    }
    return const LandingPage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trade2Gov',
      theme: ThemeData(useMaterial3: true),
      home: FutureBuilder<Widget>(
        future: _getStartPage(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return snapshot.data!;
        },
      ),
    );
  }
}
