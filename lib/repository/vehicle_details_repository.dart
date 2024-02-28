import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:safedrive/models/models.dart';
import 'package:safedrive/services/services.dart';

class VehicleDetailsRepository {
  final String baseUrl;
  final Client _httpClient;

  Future<Map<String, String>> authorizedHeader() async {
    String? token = await TokenService().getToken();
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Uri getUrl({required String url, Map<String, String>? extraParameters}) {
    final queryParameters = <String, String>{};
    if (extraParameters != null) {
      queryParameters.addAll(extraParameters);
    }

    return Uri.parse('$baseUrl/api/vehicle/$url').replace(
      queryParameters: queryParameters,
    );
  }

  VehicleDetailsRepository({
    http.Client? httpClient,
  })  : _httpClient = httpClient ?? http.Client(),
        baseUrl = dotenv.get('BACKEND_BASE_URL');

  Future<APIResponse> create(
    String category,
    String description,
    String installationDate,
    String renewalDate,
  ) async {
    final response = await _httpClient.post(
      getUrl(url: ''),
      headers: await authorizedHeader(),
      body: jsonEncode({
        "category": category,
        "description": description,
        "installationDate": installationDate,
        "renewalDate": renewalDate,
      }),
    );

    Map body = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return APIResponse(true, body["message"], data: body);
    } else {
      return APIResponse(false, body["message"]);
    }
  }

  Future<APIResponse> update(
    String vehicleDetailId,
    String category,
    String description,
    String installationDate,
    String renewalDate,
  ) async {
    final response = await _httpClient.put(
      getUrl(url: vehicleDetailId),
      headers: await authorizedHeader(),
      body: jsonEncode({
        "category": category,
        "description": description,
        "installationDate": installationDate,
        "renewalDate": renewalDate,
      }),
    );

    Map body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return APIResponse(true, body["message"], data: body);
    } else {
      return APIResponse(false, body["message"]);
    }
  }

  Future<APIResponse> delete(String vehicleDetailId) async {
    final response = await _httpClient.delete(getUrl(url: vehicleDetailId),
        headers: await authorizedHeader());

    Map body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return APIResponse(true, body["message"]);
    } else {
      return APIResponse(false, body["message"]);
    }
  }

  Future<List<VehicleDetails>> getVehicleDetailsByCategory(
      String category) async {
    final response = await _httpClient.get(
      getUrl(url: category),
      headers: await authorizedHeader(),
    );

    Map body = jsonDecode(response.body);

    log(response.body.toString());

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        return List<VehicleDetails>.from(
            body["payload"].map((data) => VehicleDetails.fromJson(data)));
      } else {
        return [];
      }
    } else {
      return [];
    }
  }
}
