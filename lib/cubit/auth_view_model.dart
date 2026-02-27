import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/model/my_user.dart';
import 'package:movies/utils/firebase_utils.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  MyUser? currentUser;

  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint(credential.user?.uid ?? 'no user');

      final userData = await FirebaseUtils.readUserFromFireStore(
        credential.user?.uid ?? '',
      );

      if (userData == null) {
        emit(AuthError('Email not found'));
        return;
      }

      debugPrint(userData.toString());

      final user = MyUser(
        id: userData.id,
        name: userData.name,
        email: userData.email,
        avatarIndex: userData.avatarIndex,
        phone: userData.phone,
      );

      currentUser = user;

      emit(AuthAuthenticated());
    } catch (e) {
      debugPrint(e.toString());

      if (e is FirebaseAuthException) {
        emit(AuthError(e.message ?? 'Login failed'));
      } else {
        emit(AuthError('Something went wrong'));
      }
    }
  }

  void logout() {
    currentUser = null;
    emit(AuthUnauthenticated());
  }
}
