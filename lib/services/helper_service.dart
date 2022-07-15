class HelperService {
  static const String host = "10.0.3.2";
  static const int port = 8000;
  static const String scheme = "http";
  static const String apiPath = "/api";

  static Uri buildUri(String path, {Map<String, dynamic>? queryParameters}) {
    return Uri(
      scheme: scheme,
      host: host,
      port: port,
      path: "$apiPath/$path",
      queryParameters: queryParameters,
    );
  }

  static String buildString(String fullPath) {
    return "$scheme://$host:$port$fullPath";
  }

  static Map<String, String> buildHeaders({String? accessToken}) {
    Map<String, String> headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

  static int getStatusType(status) {
    return (status / 100).floor() * 100;
  }
}
