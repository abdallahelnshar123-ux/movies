import 'package:cloud_firestore/cloud_firestore.dart';

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
  static Future<MyUser?> updateUser(String name , String phoneNum , int AvatarIndex , String uId){
    var querySnapshot = getUsersCollection().doc(uId);
    return querySnapshot.update({
      'name' : name,
      'phone' : phoneNum,
      'avatarIndex' : AvatarIndex,
    }).then(
          (value) {
      print('then');
      getUsersCollection().doc(uId);
    },).catchError(
        (error) {
          print(error);
        },
    );
  }

  static Future<void> deleteUser(String uId) async {
    await getUsersCollection().doc(uId).delete();
  }

  static Future<void> updateUserInFireStore(MyUser user) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.id)
        .update({
      'name': user.name,
      'phone': user.phone,
      'avatarIndex': user.avatarIndex,
    });
  }

}
