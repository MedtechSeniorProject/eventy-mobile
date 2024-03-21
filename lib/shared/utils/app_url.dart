class AppUrl {
  // TODO: Replace with your own IP4 address before running the qpp
  static const String baseUrl = 'http://192.168.1.14:3000';

  static const String login = '$baseUrl/auth/deskAgentLogin';
  static const String scan = '$baseUrl/events/attendee/';
  static const String forgotPassword = '$baseUrl/auth/forgotPassword';
}
