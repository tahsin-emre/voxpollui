import 'package:voxpollui/product/models/user_model.dart';
import 'package:voxpollui/product/services/firebase/base_service.dart';

final class AuthService extends BaseService {
  factory AuthService() => _instance;
  AuthService._();
  static final AuthService _instance = AuthService._();

  String? getCurrentUserId() {
    return auth.currentUser?.uid;
  }

  Future<UserModel?> getUser(String userId) async {
    final response = await db.collection('users').doc(userId).get();
    if (response.exists) {
      return UserModel.fromDS(response);
    }
    return null;
  }
}
