import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/initialize/models/user_model.dart';

final class AuthState extends Equatable {
  const AuthState({
    this.user,
  });

  AuthState copyWith({
    UserModel? user,
  }) {
    return AuthState(
      user: user ?? this.user,
    );
  }

  final UserModel? user;

  @override
  List<Object?> get props => [user];
}
