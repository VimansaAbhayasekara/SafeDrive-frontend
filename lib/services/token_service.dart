import 'package:safedrive/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:localstorage/localstorage.dart';

import '../common/common.dart';

class TokenService {
  late FlutterSecureStorage secureStorage;
  late Auth? auth;
  late LocalStorage storage;

  TokenService() {
    secureStorage = const FlutterSecureStorage();
    storage = LocalStorage('Safedrive');
  }

  Future<void> saveToken(String token, {Map? authData}) async {
    await secureStorage.write(key: 'token', value: token);
    if (authData != null) {
      Auth auth = Auth.fromJson(authData);
      await storage.setItem("auth", auth.toJson());
    }
  }

  Future<String?> getToken() async {
    return await secureStorage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    await secureStorage.delete(key: 'token');
    await storage.deleteItem('auth');
  }

  Future<Auth?> getAuth() async {
    if (storage.getItem("auth") is Map<String, dynamic>) {
      auth = Auth.fromJson(storage.getItem("auth"));
    } else {
      auth = storage.getItem("auth");
    }
    return auth;
  }

  Future<bool> validateToken() async {
    String? token;
    bool status = false;
    try {
      token = await secureStorage.read(key: 'token');
    } catch (e) {
      status = false;
    } finally {
      if (token == null) {
        status = false;
      } else {
        Map<String, dynamic> json = parseJwtPayLoad(token);
        var expDate = DateTime.fromMillisecondsSinceEpoch(json['exp'] * 1000);
        var currentDate = DateTime.fromMillisecondsSinceEpoch(
            DateTime.now().millisecondsSinceEpoch);

        if (!currentDate.isBefore(expDate)) {
          status = true;
        } else {
          if (getAuth() != null) {
            status = true;
          } else {
            await const FlutterSecureStorage().delete(key: "token");
            status = false;
          }
        }
      }
    }
    return status;
  }
}
