import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:safedrive/services/services.dart';

import '../models/models.dart';

class AuthRepository {
  final String baseUrl;
  final Client _httpClient;

  Map<String, String> header = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json; charset=UTF-8',
  };

  Uri getUrl({required String url, Map<String, String>? extraParameters}) {
    final queryParameters = <String, String>{};
    if (extraParameters != null) {
      queryParameters.addAll(extraParameters);
    }

    return Uri.parse('$baseUrl/api/auth/$url').replace(
      queryParameters: queryParameters,
    );
  }

  AuthRepository({
    http.Client? httpClient,
  })  : _httpClient = httpClient ?? http.Client(),
        baseUrl = dotenv.get('BACKEND_BASE_URL');

  Future<APIResponse> login(String email, String password, String? messageToken) async {
    final response = await _httpClient.post(
      getUrl(url: 'login'),
      headers: header,
      body: jsonEncode({
        "email": email,
        "password": password,
        "message_token": "$messageToken"
      }),
    );

    Map body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Map auth = body["payload"]["user"];
      String token = body["payload"]["token"];
      await TokenService().saveToken(token, authData: auth);
      return APIResponse(true, body['message'], data: body['payload']);
    } else {
      return APIResponse(false, body['message']);
    }
  }

  Future<APIResponse> register(
    String email,
    String password,
    String role,
    String province,
    String district,
    String? mobile,
    String? businessLicenseNumber,
  ) async {
    final response = await _httpClient.post(
      getUrl(url: 'register'),
      headers: header,
      body: jsonEncode({
        "email": email,
        "password": password,
        "role": role,
        "province": province,
        "district": district,
        "mobile": mobile,
        "businessLicenseNumber": businessLicenseNumber
      }),
    );
    Map body = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return APIResponse(true, body['message'], data: body['payload']);
    } else {
      return APIResponse(false, body['message']);
    }
  }
}
