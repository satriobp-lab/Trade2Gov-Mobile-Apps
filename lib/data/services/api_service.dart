import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://api2.trade2gov.com/api/t2gmobile';

  Future<Map<String, dynamic>> post(
      String endpoint,
      Map<String, dynamic> body,
      ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 15));

      final decoded = jsonDecode(response.body);

      if (response.statusCode == 200 && decoded['status'] == 'OK') {
        return decoded;
      } else {
        throw Exception(decoded['desc'] ?? 'LOGIN_FAILED');
      }
    } on SocketException {
      throw Exception("NO_INTERNET");
    } on HttpException {
      throw Exception("SERVER_ERROR");
    } on FormatException {
      throw Exception("BAD_RESPONSE");
    }
  }

  Future<dynamic> postRaw(
      String endpoint,
      Map<String, dynamic> body,
      ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    print("URL: $baseUrl/$endpoint");
    print("BODY: ${jsonEncode(body)}");
    print("STATUS: ${response.statusCode}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    // 🔥 kalau 500 anggap tidak ada data
    if (response.statusCode == 500) {
      return null;
    }

    throw Exception('Terjadi kesalahan server');
  }
}
