import 'dart:io';

import 'package:budget/services/localstorage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<String?> getAppDocumentsPath() async {
    // Check if the app is running on the web
    if (kIsWeb) {
      // Handle the web case - return null or a web-specific path
      return null;
    } else {
      // For mobile/desktop, use the path_provider method
      // final directory = await getApplicationDocumentsDirectory();
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      return documentsDirectory.path;
    }
  }

  Future<Database> _initDB() async {
    WidgetsFlutterBinding.ensureInitialized(); // Assure l'initialisation:cite[1]

    String? pathDocument = await getAppDocumentsPath();
    String path = join(pathDocument ?? '', 'mes_depenses.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXSIST depenses (
        id TEXT PRIMARY KEY,
        type TEXT NOT NULL,
        name TEXT NOT NULL,
        montant TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');
  }
}
