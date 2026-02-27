import 'package:movies/model/my_user.dart';
import 'package:movies/utils/dialog_utils.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}


class AuthAuthenticated extends AuthState {
  final MyUser user;

  AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}


class AuthUpdateSuccess extends AuthState {
  final MyUser updatedUser;

  AuthUpdateSuccess(this.updatedUser);

  @override
  List<Object?> get props => [updatedUser];
}

class AuthDeleteSuccess extends AuthState{}
