import 'package:flutter_test/flutter_test.dart';
import 'package:trade2gov/data/models/login_response_model.dart';

void main() {

  test('LoginResponseModel parsing success', () {

    final json = {
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

    final model = LoginResponseModel.fromJson(json);

    expect(model.idUser, 593);
    expect(model.email, "jakrhifa@gmail.com");
  });

  test('LoginResponseModel parsing error', () {

    final json = {
      "status": "OK",
      "data": null
    };

    expect(
          () => LoginResponseModel.fromJson(json),
      throwsException,
    );
  });
}