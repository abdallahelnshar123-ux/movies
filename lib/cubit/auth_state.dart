import 'package:movies/model/my_user.dart';
import 'package:movies/utils/dialog_utils.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {

  DialogUtils.showLoading();
}

class AuthAuthenticated extends AuthState {
  final MyUser user;

  AuthAuthenticated(this.user);

  Future
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
