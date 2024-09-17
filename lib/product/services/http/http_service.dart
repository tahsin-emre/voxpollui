import 'package:http/http.dart' as http;
import 'package:voxpollui/product/services/http/http_endpoints.dart';

final class HttpService {
  factory HttpService() => _instance;
  HttpService._();
  static final HttpService _instance = HttpService._();

  Future<http.Response> sendRequest(
    HttpEndpoints endpoint,
    Map<String, dynamic> body,
  ) async {
    final response = await http.post(
      endpoint.toUri,
      body: body,
    );
    return response;
  }
}
