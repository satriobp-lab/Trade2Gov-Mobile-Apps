import '../services/api_service.dart';
import '../models/billing_response_model.dart';
import '../securestorage/secure_storage_service.dart';

class BillingRepository {
  final ApiService _apiService = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<List<BillingResponseModel>> getBilling() async {
    final userId = await _storage.getUserId();

    if (userId == null) {
      throw Exception('User belum login');
    }

    final response = await _apiService.postRaw(
      'billing',
      {'id_user': userId},
    );

    /// HANDLE DUA KEMUNGKINAN
    final List data = response is List
        ? response
        : response['data'];

    final billings = data
        .map((e) => BillingResponseModel.fromJson(e))
        .toList()
      ..sort((a, b) => b.billingId.compareTo(a.billingId));

    return billings;
  }
}
