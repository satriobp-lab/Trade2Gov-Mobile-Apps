import 'package:flutter_test/flutter_test.dart';
import 'package:trade2gov/data/repositories/auth_repository.dart';
import 'package:trade2gov/data/services/api_service.dart';
import 'package:trade2gov/data/securestorage/secure_storage_service.dart';

class FakeStorageService extends SecureStorageService {
  bool saved = false;

  @override
  Future<void> saveLoginSession({
    required String userId,
    required String userHash,
    required String email,
    required String name,
  }) async {
    saved = true;
  }
}

class FakeApiService implements ApiService {
  final Map<String, dynamic>? response;
  final bool shouldThrow;

  FakeApiService({this.response, this.shouldThrow = false});

  @override
  Future<Map<String, dynamic>> post(
      String endpoint,
      Map<String, dynamic> body,
      ) async {

    if (shouldThrow) {
      throw Exception("Login gagal");
    }

    return response!;
  }

  @override
  Future<dynamic> postRaw(
      String endpoint,
      Map<String, dynamic> body,
      ) async {
    return response;
  }
}

void main() {

  final mockResponse = {
    "status": "OK",
    "desc": "Login sukses.",
    "data": {
      "id_user": 593,
      "id_user_hash":
      "6bb5e48f95e34f9c9821737b03fb5628c372409bd7ba17bd65bf030b2f47366c",
      "npwp": "017439274046000",
      "email": "jakrhifa@gmail.com",
      "nama": "Demo Account 1",
      "role_id": 4
    }
  };

  test('Login success with valid user', () async {

    final api = FakeApiService(response: mockResponse);
    final storage = FakeStorageService();

    final repo = AuthRepository(
      apiService: api,
      storageService: storage,
    );

    final result = await repo.login(
      email: "jakrhifa@gmail.com",
      password: "P@ssw0rd123",
    );

    expect(result.email, "jakrhifa@gmail.com");
    expect(storage.saved, true);
  });

  test('Login wrong password throws exception', () async {

    final api = FakeApiService(shouldThrow: true);
    final storage = FakeStorageService();

    final repo = AuthRepository(
      apiService: api,
      storageService: storage,
    );

    expect(
          () => repo.login(
        email: "jakrhifa@gmail.com",
        password: "wrong",
      ),
      throwsException,
    );
  });

  test('Login empty email', () async {

    final api = FakeApiService(shouldThrow: true);
    final storage = FakeStorageService();

    final repo = AuthRepository(
      apiService: api,
      storageService: storage,
    );

    expect(
          () => repo.login(
        email: "",
        password: "123456",
      ),
      throwsException,
    );
  });

  test('Login empty password', () async {

    final api = FakeApiService(shouldThrow: true);
    final storage = FakeStorageService();

    final repo = AuthRepository(
      apiService: api,
      storageService: storage,
    );

    expect(
          () => repo.login(
        email: "user@mail.com",
        password: "",
      ),
      throwsException,
    );
  });

  test('Login invalid email format', () async {

    final api = FakeApiService(shouldThrow: true);
    final storage = FakeStorageService();

    final repo = AuthRepository(
      apiService: api,
      storageService: storage,
    );

    expect(
          () => repo.login(
        email: "invalidemail",
        password: "123456",
      ),
      throwsException,
    );
  });

}