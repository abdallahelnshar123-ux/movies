import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../model/my_user.dart';


class FirebaseUtils {
  static CollectionReference<MyUser> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUserToFireStore(MyUser myUser) {
    return getUsersCollection().doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    var querySnapshot = await getUsersCollection().doc(uId).get();
    return querySnapshot.data();
  }

  static Future<void> updateUserDataToFirestore(MyUser user) async {
    var querySnapshot = getUsersCollection().doc(user.id);
    await querySnapshot.update(user.toFireStore());
  }

  static Future<void> deleteUserFromFirestore(String uId) async {
    await getUsersCollection().doc(uId).delete();
  }


  static Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignIn signIn = GoogleSignIn.instance;
    await signIn.initialize(
        clientId: '503224830946-tm277q3ec3la0j61i5ds6dc222jhn6sf.apps.googleusercontent.com');

    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await signIn.authenticate();
    // final GoogleSignInAccount? googleUser = await GoogleSignIn.instance.authenticate();
    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken);

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }

    return null;
  }
}
