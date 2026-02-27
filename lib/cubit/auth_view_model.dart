import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/model/my_user.dart';
import 'package:movies/utils/dialog_utils.dart';
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
        if (e.message ==
            'The supplied auth credential is incorrect, malformed or has expired.') {
          emit(AuthError('Email or password is incorrect ! '));
        }
      } else {
        emit(AuthError('Something went wrong'));
      }
    }
  }

  void logout() {
    currentUser = null;
    emit(AuthUnauthenticated());
  }

  Future<void> deleteUserAccount() async {
    try {
      emit(AuthLoading());

      // Delete from Firestore
      await FirebaseUtils.deleteUser(currentUser!.id);

      // Delete from Firebase Auth
      await FirebaseAuth.instance.currentUser?.delete();

      currentUser = null;
      emit(AuthDeleteSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> updateUserProfile({
    required String name,
    required String phone,
    required int avatarIndex,
  }) async {
    try {
      if (currentUser == null) {
        emit(AuthError("User not logged in"));
        return;
      }

      emit(AuthLoading());

      final updatedUser = MyUser(
        id: currentUser!.id,
        email: currentUser!.email,
        name: name,
        phone: phone,
        avatarIndex: avatarIndex,
      );

      await FirebaseUtils.updateUserInFireStore(updatedUser);

      currentUser = updatedUser;

      emit(AuthUpdateSuccess(updatedUser)); // هنا الحالة الجديدة
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
