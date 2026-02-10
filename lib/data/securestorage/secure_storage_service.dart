import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  static const _keyUserId = 'user_id';
  static const _keyUserHash = 'user_hash';
  static const _keyEmail = 'email';
  static const _keyName = 'name';

  Future<void> saveLoginSession({
    required String userId,
    required String userHash,
    required String email,
    required String name,
  }) async {
    await _storage.write(key: _keyUserId, value: userId);
    await _storage.write(key: _keyUserHash, value: userHash);
    await _storage.write(key: _keyEmail, value: email);
    await _storage.write(key: _keyName, value: name);
  }

  Future<bool> isLoggedIn() async {
    return await _storage.read(key: _keyUserHash) != null;
  }

  Future<void> clearSession() async {
    await _storage.deleteAll();
  }

  Future<String?> getUserName() async {
    return await _storage.read(key: _keyName);
  }

  Future<String?> getEmail() async {
    return await _storage.read(key: _keyEmail);
  }

}
