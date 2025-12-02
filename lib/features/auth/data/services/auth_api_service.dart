import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/constants/api_routes.dart';
import '../models/password_complexity_model.dart';

class AuthApiService {
  final _storage = const FlutterSecureStorage();

   AuthApiService();

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'access_token');
  }

  Future<void> getCurrentLoginInformations() async {
    final token = await getToken();
    if (token == null) return;

    try {
      final Response response = await DioClient.getRequest(
        ApiRoutes.getCurrentLoginInfo,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print("✅ User Info Response: ${response.data}");

    } catch (e) {
      await deleteToken();
      rethrow;
    }
  }

  Future<PasswordComplexity> getPasswordComplexitySetting() async {
    final Response response = await DioClient.getRequest(
      ApiRoutes.getPasswordComplexitySetting,
    );
    final data = response.data as Map<String, dynamic>;
    final dynamic result = data['result'] ?? data;
    final dynamic setting = result is Map<String, dynamic>
        ? (result['setting'] ?? result)
        : result;

    if (setting is! Map<String, dynamic>) {
      throw Exception('Invalid password complexity response shape');
    }
    return PasswordComplexity.fromJson(setting as Map<String, dynamic>);
  }

  Future<int> getFirstRegistrableEdition() async {
    final Response response = await DioClient.getRequest(
      ApiRoutes.getEditionsForSelect,
    );

    final data = response.data as Map<String, dynamic>;
    final result = data['result'] ?? data;

    if (result is! Map<String, dynamic> || !result.containsKey('editionsWithFeatures')) {
      throw Exception('Invalid editions response shape');
    }

    final editions = result['editionsWithFeatures'] as List<dynamic>;

    final registrableEdition = editions.firstWhere(
          (element) {
        final edition = element['edition'];
        return edition != null && edition['isRegistrable'] == true;
      },
      orElse: () => null,
    );

    if (registrableEdition == null) {
      throw Exception('No registrable edition found');
    }

    return registrableEdition['edition']['id'] as int;
  }

  Future<TenantAvailability> checkTenantAvailability(String tenancyName) async {
    final Response response = await DioClient.postRequest(
      ApiRoutes.isTenantAvailable,
      data: {'tenancyName': tenancyName},
    );

    final data = response.data as Map<String, dynamic>;
    final dynamic result = data['result'] ?? data;

    if (result is! Map<String, dynamic>) {
      throw Exception('Invalid tenant availability response shape');
    }

    return TenantAvailability.fromJson(result as Map<String, dynamic>);
  }

  Future<void> registerTenant({
    required String adminEmailAddress,
    required String adminFirstName,
    required String adminLastName,
    required String adminPassword,
    required String tenancyName,
    required int editionId,
  }) async {
    final Response response = await DioClient.postRequest(
      ApiRoutes.registerTenant,
      data: {
        'adminEmailAddress': adminEmailAddress,
        'adminFirstName': adminFirstName,
        'adminLastName': adminLastName,
        'adminPassword': adminPassword,
        'captchaResponse': null,
        'editionId': editionId,
        'name': tenancyName,
        'tenancyName': tenancyName,
        'timeZone': 'UTC',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register tenant');
    }
  }

  Future<Map<String, dynamic>> authenticate({
    required String userNameOrEmailAddress,
    required String password,
    required String tenancyName,
  }) async {
    final Response response = await DioClient.postRequest(
      ApiRoutes.authenticate,
      data: {
        'ianaTimeZone': 'UTC',
        'password': password,
        'rememberClient': false,
        'returnUrl': null,
        'singleSignIn': false,
        'tenantName': tenancyName,
        'userNameOrEmailAddress': userNameOrEmailAddress,
      },
    );

    final data = response.data as Map<String, dynamic>;
    final dynamic result = data['result'];

    if (result == null) {
      throw Exception('Authentication failed');
    }

    return result as Map<String, dynamic>;
  }
}

class TenantAvailability {
  final int? tenantId;

  const TenantAvailability({
    required this.tenantId,
  });

  bool get canRegister => tenantId == null;

  factory TenantAvailability.fromJson(Map<String, dynamic> json) {
    return TenantAvailability(tenantId: json['tenantId'] as int?);
  }
}