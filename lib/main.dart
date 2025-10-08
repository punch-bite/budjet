import 'package:budget/models/depense.dart';
import 'package:budget/views/home_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DepenseAdapter()); // Enregistrement de l'adaptateur
  await Hive.openBox<Depense>('depensesBox');
  
  runApp(
    DevicePreview(
      enabled: true, // Active le mode preview
      builder:
          (context) =>
              const MyApp(), // Remplacez par le nom de votre widget racine
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Budjet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', ),
      locale: DevicePreview.locale(context), // Utilise la locale du preview
      builder: DevicePreview.appBuilder, // Applique le builder pour le preview
      home: HomePage(),
      // Votre page d'accueil
    );
  }
}
