import 'package:budget/views/home_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true, // Active le mode preview
      builder: (context) => const MyApp(), // Remplacez par le nom de votre widget racine
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Mon Budjet',
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context), // Utilise la locale du preview
      builder: DevicePreview.appBuilder, // Applique le builder pour le preview
      home: HomePage(),
       // Votre page d'accueil
    );
  }
}
 
