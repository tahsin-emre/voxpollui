import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_state.dart';
import 'package:voxpollui/product/models/user_model.dart';

final class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());

  void setUser(UserModel user) {
    emit(state.copyWith(user: user));
  }
}
