import '../models/login_response_model.dart';
import '../services/api_service.dart';
import '../securestorage/secure_storage_service.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();
  final SecureStorageService _storageService = SecureStorageService();

  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiService.post(
      'login',
      {
        'email': email,
        'password': password,
      },
    );

    final user = LoginResponseModel.fromJson(response);

    await _storageService.saveLoginSession(
      userId: user.idUser.toString(),
      userHash: user.idUserHash,
      email: user.email,
      name: user.nama,
    );

    return user;
  }
}
