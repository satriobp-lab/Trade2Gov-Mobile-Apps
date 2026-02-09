import 'package:flutter/material.dart';
import '/landing/landing_page.dart'; // Sesuaikan path file landing_page kamu

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trade2Gov',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LandingPage(), // Membuka LandingPage saat start
    );
  }
}