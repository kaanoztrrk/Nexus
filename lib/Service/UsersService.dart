import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:nexus/Models/Users.dart';

class UserService {
  late Box _userBox;

  Future<void> init() async {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    _userBox = await Hive.openBox('users'); // 'users' adında bir kutu oluştur
  }

  Future<void> addUser(User user) async {
    await _userBox.put('user', user.toJson()); // Kullanıcıyı kutuya ekleyin
  }

  Future<User?> getUser() async {
    final userData = _userBox.get('user'); // Kullanıcı verilerini kutudan al
    if (userData != null) {
      return User.fromJson(userData); // Kullanıcı nesnesini oluştur ve döndür
    } else {
      return null;
    }
  }

  Future<void> closeBox() async {
    await _userBox.close(); // Kutuyu kapat
  }
}
