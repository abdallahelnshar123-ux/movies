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
      debugPrint('\n \n');
      debugPrint(credential.user?.uid ?? 'no user' );

      debugPrint('\n \n');
      final userData = await FirebaseUtils.readUserFromFireStore(
        credential.user?.uid ?? 'TaCucQMGdnSW9WlPed0gfXE552n1',
      );
      debugPrint('done' );
      debugPrint('\n \n');
      debugPrint(userData.toString() );

      debugPrint('\n \n');
      final user = MyUser(
        id: userData?.id ?? 'no id' ,
        name: userData?.name??'no id',
        email: userData?.email??'no id',
        avatarIndex: userData?.avatarIndex?? 5,
        phone: userData?.phone??'no id',
      );

      currentUser = user;

      emit(AuthAuthenticated(user));
    } catch (e) {
      debugPrint(e.toString());
      emit(AuthError(e.toString()));
      // if (e is FirebaseAuthException) {
      //   emit(AuthError(e.message ?? 'Login failed'));
      // } else {
      //   emit(AuthError('Something went wrong'));
      // }
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
