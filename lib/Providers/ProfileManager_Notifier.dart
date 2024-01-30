import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileManager {
  static const String _keyProfilePicture = 'profile_picture';

  static String? _profilePicture;

  static String? get profilePicture => _profilePicture;

  static Future<void> init() async {
    _profilePicture = await _loadProfilePicture();
  }

  static Future<void> _saveProfilePicture(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyProfilePicture, imagePath);
    _profilePicture = imagePath;
  }

  static Future<String?> _loadProfilePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyProfilePicture);
  }

  static Future<void> saveProfilePicture(String imagePath) async {
    await _saveProfilePicture(imagePath);
  }

  static Future<void> clearProfilePicture() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyProfilePicture);
    _profilePicture = null;
  }
}

final profileManagerProvider = Provider((ref) => ProfileManager());
