import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class WishRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getWishStream() {
    try {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    final stream = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('wishList')
        .snapshots();
        return stream;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<void> add({required String imageURL, title}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('wishList')
        .add(
      {
        'imageURL': imageURL,
        'title': title,
      },
    );
  }

  Future<void> delete({required String documentID}) {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('wishList')
        .doc(documentID)
        .delete();
  }
}