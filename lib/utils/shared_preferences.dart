import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _preferences;

  static const _keyUserNotes = 'notes';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUserNotes(String notes) async =>
      await _preferences.setString(_keyUserNotes, notes);

  static String? getUserNotes() => _preferences.getString(_keyUserNotes);
}