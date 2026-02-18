import 'dart:convert'; // <-- tambahkan ini
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:trade2gov/data/models/mailbox_response_model.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  static const _keyUserId = 'user_id';
  static const _keyUserHash = 'user_hash';
  static const _keyEmail = 'email';
  static const _keyName = 'name';

  Future<String?> getUserId() async {
    return await _storage.read(key: _keyUserId);
  }

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

  // Simpan daftar mailbox terbaca sebagai JSON string
  Future<void> saveReadMails(List<MailboxResponseModel> mails) async {
    final jsonList = mails.map((e) => {
      'id_user': e.idUser,
      'msg': e.message,
    }).toList();
    await _storage.write(key: 'read_mails', value: jsonEncode(jsonList));
  }

  // Ambil daftar mailbox terbaca
  Future<List<MailboxResponseModel>> getReadMails() async {
    final data = await _storage.read(key: 'read_mails');
    if (data == null) return [];
    final List list = jsonDecode(data);
    return list.map((e) => MailboxResponseModel.fromJson(e)).toList();
  }

  //save tab mailbox state
  Future<void> saveLastTab(int index) async {
    await _storage.write(key: 'last_mailbox_tab', value: index.toString());
  }

  Future<int> getLastTab() async {
    final value = await _storage.read(key: 'last_mailbox_tab');
    if (value == null) return 0;
    return int.tryParse(value) ?? 0;
  }
}
