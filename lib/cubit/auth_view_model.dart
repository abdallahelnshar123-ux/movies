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
      emit(AuthLoginLoading());

      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint(credential.user?.uid ?? 'no user');

      final userData = await FirebaseUtils.readUserFromFireStore(
        credential.user?.uid ?? '',
      );

      if (userData == null) {
        emit(AuthLoginError('Email not found'));
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
          emit(AuthLoginError('Email or password is incorrect ! '));
        }
      } else {
        emit(AuthLoginError('Something went wrong'));
      }
    }
  }

  void logout() {
    currentUser = null;
    emit(AuthUnauthenticated());
  }

  Future<void> deleteUserAccount(String password) async {
    try {
      emit(AuthDeleteLoading());

      final user = FirebaseAuth.instance.currentUser;

      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);
      await FirebaseUtils.deleteUserFromFirestore(user.uid);
      await user.delete();

      currentUser = null;

      emit(AuthDeleteSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        emit(AuthDeleteError("Wrong password"));
      } else if (e.code == 'requires-recent-login') {
        emit(AuthDeleteError("Please login again"));
      } else {
        emit(AuthDeleteError(e.message ?? "Delete failed"));
      }
    } catch (e) {
      emit(AuthDeleteError("Something went wrong"));
    }
  }

  Future<void> updateUserData({
    required String name,
    required String phone,
    required int avatarIndex,
  }) async {
    try {
      emit(AuthUpdateLoading());
      if (currentUser == null) {
        emit(AuthUpdateError("User not logged in"));
        return;
      }

      final updatedUser = MyUser(
        id: currentUser!.id,
        email: currentUser!.email,
        name: name,
        phone: phone,
        avatarIndex: avatarIndex,
      );

      await FirebaseUtils.updateUserDataToFirestore(updatedUser);

      currentUser = updatedUser;

      emit(AuthUpdateSuccess());
    } catch (e) {
      emit(AuthUpdateError(e.toString()));
    }
  }
}
