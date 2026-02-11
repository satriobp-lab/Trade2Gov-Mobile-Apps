import '../services/api_service.dart';
import '../securestorage/secure_storage_service.dart';
import '../models/mailbox_response_model.dart';

class MailboxRepository {
  final ApiService _apiService = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<List<MailboxResponseModel>> getMailbox() async {
    final userId = await _storage.getUserId();

    if (userId == null) {
      throw Exception('User belum login');
    }

    final response = await _apiService.postRaw(
      'get_mailbox',
      {'id_user': userId},
    );

    final List data = response as List;

    return data
        .map((e) => MailboxResponseModel.fromJson(e))
        .toList();
  }
}
