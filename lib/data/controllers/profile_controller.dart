import '../services/api_service.dart';
import '../models/profile_response_model.dart';
import '../securestorage/secure_storage_service.dart';

class ProfileController {
  static final ApiService _api = ApiService();
  static final SecureStorageService _storage = SecureStorageService();

  static Future<ProfileResponseModel> fetchProfile() async {
    final userId = await _storage.getUserId();

    final response = await _api.postRaw(
      'profile',
      {
        'id_user': userId,
      },
    );

    return ProfileResponseModel.fromJson(response[0]);
  }
}