import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // Don't forget to import this for JSON conversion

class Localstorage {
  static const String _depensekey = 'depense';

  Future<void> saveDepenses(List<Map<String, dynamic>> depenses) async {
    final pref = await SharedPreferences.getInstance();
    // Convert the entire list to a JSON string
    String encodedData = jsonEncode(depenses);
    // Save the string
    await pref.setString(_depensekey, encodedData);
  }

  Future<List<Map<String, dynamic>>> loadDepenses() async {
    final pref = await SharedPreferences.getInstance();
    // Retrieve the string
    String? jsonString = pref.getString(_depensekey);
    
    // Decode the string back into a list of maps
    List<dynamic> decodedList = jsonDecode(jsonString!);
    // Convert the list<dynamic> to List<Map<String, dynamic>>
    List<Map<String, dynamic>> depenses = decodedList.cast<Map<String, dynamic>>();
    return depenses;
    }
}