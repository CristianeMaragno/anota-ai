import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _keyUserEmail = 'user_email';

  static Future setUserEmail(String email) async =>
      await _storage.write(key: _keyUserEmail, value: email);

  static Future<String?> getUserEmail() async =>
      await _storage.read(key: _keyUserEmail);
}