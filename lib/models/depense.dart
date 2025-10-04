import 'package:hive/hive.dart';

part 'depense.g.dart'; // This line is CRITICAL

@HiveType(typeId: 0) // Ensure typeId is unique
class Depense extends HiveObject {
  @HiveField(0)
  final String type;
  
  @HiveField(1)
  final String name;
  
  @HiveField(2)
  final String montant;
  
  @HiveField(3)
  final DateTime created_at;

  Depense({
    required this.type,
    required this.name,
    required this.montant,
    required this.created_at,
  });
}