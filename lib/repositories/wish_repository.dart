import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yourtripplaner/Features/models/wish_model.dart';

class WishRepository {
  Stream<List<WishModel>> getWishStream() {
    final userID = FirebaseAuth.instance.currentUser?.uid;
    if (userID == null) {
      throw Exception('User is not logged in');
    }
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('wishList')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return WishModel(
          id: doc.id,
          imageURL: doc['imageURL'],
          title: doc['title'],
        );
      }).toList();
    });
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
