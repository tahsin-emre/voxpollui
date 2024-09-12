import 'package:voxpollui/product/models/user_model.dart';
import 'package:voxpollui/product/services/firebase/base_service.dart';

final class UserService extends BaseService {
  factory UserService() => _instance;
  UserService._();
  static final UserService _instance = UserService._();

  Future<UserModel?> getUser(String userId) async {
    final response = await db.collection('users').doc(userId).get();
    if (response.exists) {
      return UserModel.fromDS(response);
    }
    return null;
  }
}
