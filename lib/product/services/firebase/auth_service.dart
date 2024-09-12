import 'package:voxpollui/product/services/firebase/base_service.dart';

final class AuthService extends BaseService {
  factory AuthService() => _instance;
  AuthService._();
  static final AuthService _instance = AuthService._();

  String? getCurrentUserId() {
    return auth.currentUser?.uid;
  }
}
