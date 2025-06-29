class EndPoints {
  static String baseUrl = "https://planitly-backend.vercel.app/";

  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String refreshToken = 'auth/refresh-token';
  static const String forgotPassword = 'auth/forgot-password';
  static const String logout = 'auth/logout-device';

  static const String home = 'home/';
  static const String notifications = 'notifications';
  static const String fcmToken = 'notifications/register-fcm-token';

  static String subjects(String id) => 'subjects/$id/full-data';
  static String subject(String id) => 'subjects/$id';

  static String data_transfer = 'datatransfers/';

  static String pages = 'subjects/';

  static String profile = 'profile/';
  static String uploadProfileImage = '/profile/upload-image';
  static String changePassword = 'profile/change-password';

  static String categories = 'categories/';
  static String uncategorizedPages = 'categories/uncategorized';
  static String categorySubjects(String categoryName) =>
      'categories/$categoryName/subjects';
  static String deleteCategory(String categoryName) =>
      'categories/$categoryName';

  static String chat = 'chat/';
  static String getUserMessages = 'chat/messages';
}
