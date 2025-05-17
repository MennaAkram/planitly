class EndPoints {
  static String baseUrl = "https://planitly-backend.vercel.app/";

  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String refreshToken = 'auth/refresh-token';

  static const String notifications = 'notifications';

  static String subjects(String id) => 'subjects/$id/full-data';
  
  static String data_transfer = 'datatransfers/';
}