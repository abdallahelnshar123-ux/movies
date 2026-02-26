import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/model/my_user.dart';
import 'package:movies/utils/firebase_utils.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  MyUser? currentUser;

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final response = await FirebaseUtils.readUserFromFireStore(
          credential.user?.uid ?? '');

      final user = MyUser(
        id: response!.id,
        name: response.name,
        email: response.email,
        avatarIndex: response.avatarIndex,
        phone: response.phone,
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
