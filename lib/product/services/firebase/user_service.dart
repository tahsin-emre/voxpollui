import 'dart:developer';

import 'package:voxpollui/product/initialize/models/user_model.dart';
import 'package:voxpollui/product/services/firebase/base_service.dart';

final class UserService extends BaseService {
  factory UserService() => _instance;
  UserService._();
  static final UserService _instance = UserService._();

  /// Get the user by [userId] as [String]
  /// Return [UserModel] if the user exists, otherwise return null
  Future<UserModel?> getUser(String userId) async {
    try {
      final response = await db
          .collection(FireStoreCollections.users.name)
          .doc(userId)
          .get();
      if (response.exists) {
        return UserModel.fromJson(response.data()!, response.id);
      }
      return null;
    } on Exception catch (e) {
      log(e.toString());
      return null;
    }
  }

  /// Create a new user with [user] as [UserModel]
  /// Return true if the user is created successfully, otherwise return false
  Future<bool> createUser(UserModel user) async {
    try {
      await db.collection('users').doc(user.id).set(user.toMap());
      return true;
    } on Exception {
      return false;
    }
  }
}
