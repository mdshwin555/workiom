class ApiRoutes {
  ApiRoutes._();

  static const String baseUrl = 'https://api.workiom.club';

  static const String getCurrentLoginInfo =
      '/api/services/app/Session/GetCurrentLoginInformations';

  static const String getEditionsForSelect =
      '/api/services/app/TenantRegistration/GetEditionsForSelect';

  static const String getPasswordComplexitySetting =
      '/api/services/app/Profile/GetPasswordComplexitySetting';

  static const String isTenantAvailable =
      '/api/services/app/Account/IsTenantAvailable';

  static const String registerTenant =
      '/api/services/app/TenantRegistration/RegisterTenant';

  static const String authenticate = '/api/TokenAuth/Authenticate';
}
