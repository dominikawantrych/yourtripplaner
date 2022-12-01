import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourtripplaner/Features/models/wish_model.dart';

class WishRepository {
  Stream<List<WishModel>> getWishStream() {
    return FirebaseFirestore.instance
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

  Future<void> add({required String imageURL, title})  {
    return
   FirebaseFirestore.instance.collection('wishList').add(
        {
          'imageURL': imageURL,
          'title' : title,
        },
      );
  }

  Future<void> delete({required String documentID}) {
     return FirebaseFirestore.instance
          .collection('wishList')
          .doc(documentID)
          .delete();
  }
}
