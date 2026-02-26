import 'package:bloc/bloc.dart';

import '../model/user_model.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  UserModel? currentUser;

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());

      final response = await ApiManager.login(email, password);

      final user = UserModel(
        id: response['id'],
        name: response['name'],
        email: response['email'],
        image: response['image'],
        phone: response['phone'],
      );

      currentUser = user;

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void logout() {
    currentUser = null;
    emit(AuthUnauthenticated());
  }
}
