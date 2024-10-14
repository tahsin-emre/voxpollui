import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_state.dart';
import 'package:voxpollui/product/initialize/models/owner_model/user_model.dart';
import 'package:voxpollui/product/services/firebase/auth_service.dart';
import 'package:voxpollui/product/services/firebase/user_service.dart';

final class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());
  final _authService = AuthService();
  final _userService = UserService();

  /// Sign out the current user
  Future<void> signOut() async {
    await _authService.signOut();
    // ignore: avoid_redundant_argument_values
    emit(const AuthState());
  }

  /// Handle the current user id as [String]
  String? handleCurrentUserId() {
    return _authService.getCurrentUserId();
  }

  /// Handle the current user phone as [String]
  String? handleCurrentUserPhone() {
    return _authService.getCurrentUserPhone();
  }

  /// Get the user by [userId] as [String]
  /// Return [UserModel] if the user exists, otherwise return null
  Future<UserModel?> getUser(String userId) async {
    final user = await _userService.getUser(userId);
    if (user == null) return null;
    emit(state.copyWith(user: user));
    return user;
  }

  void updateUser(UserModel user) {
    _userService.updateUser(user);
    emit(state.copyWith(user: user));
  }
}
