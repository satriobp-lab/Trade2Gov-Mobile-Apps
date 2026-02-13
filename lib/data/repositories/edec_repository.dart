import '../services/api_service.dart';
import '../securestorage/secure_storage_service.dart';
import '../models/edec_response_model.dart';

class EdecRepository {
  final ApiService _api = ApiService();
  final SecureStorageService _storage = SecureStorageService();

  Future<EdecResponseModel> fetchDashboard() async {
    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'edeclaration/dashboard',
      {
        "USER_ID": userId,
      },
    );

    return EdecResponseModel.fromJson(response);
  }
}
