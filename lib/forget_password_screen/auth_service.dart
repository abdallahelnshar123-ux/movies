import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> sendResetPasswordEmail(String email) async {
    final trimmed = email.trim();

    if (trimmed.isEmpty) {
      throw FirebaseAuthException(
        code: 'empty-email',
        message: 'Please enter your email.',
      );
    }

    await _auth.sendPasswordResetEmail(email: trimmed);
  }
}