import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_state.dart';
import 'package:voxpollui/product/models/user_model.dart';
import 'package:voxpollui/product/services/firebase/auth_service.dart';

final class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());
  final AuthService _authService = AuthService();
  String? handleCurrentUser() {
    return _authService.getCurrentUserId();
  }

  Future<UserModel?> getUser(String userId) async {
    final user = await _authService.getUser(userId);
    if (user == null) return null;
    emit(state.copyWith(user: user));
    return user;
  }
}
