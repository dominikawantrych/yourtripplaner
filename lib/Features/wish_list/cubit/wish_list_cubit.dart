import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:yourtripplaner/Features/models/wish_model.dart';

part 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit()
      : super(const WishListState(
          documents: [],
          errorMessage: '',
          isloading: false,
        ));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(const WishListState(
      documents: [],
      errorMessage: '',
      isloading: true,
    ));

    _streamSubscription = FirebaseFirestore.instance
        .collection('wishList')
        .snapshots()
        .listen((data) {
      final wishModels = data.docs.map((doc) {
        return WishModel(
          id: doc.id,
          imageURL: doc['imageURL'],
          title: doc['title'],
        );
      }).toList();
      emit(
        WishListState(
          documents: wishModels,
          isloading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          WishListState(
            documents: const [],
            isloading: false,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  Future<void> add({required String imageURL, title}) async {
    try {
      await FirebaseFirestore.instance.collection('wishList').add(
        {
          'imageURL': imageURL,
          'title' : title,
        },
      );
      emit(WishListState(
        documents: state.documents,
        errorMessage: '',
        isloading: false,
      ));
    } catch (error) {
      emit(WishListState(
        documents: const [],
        errorMessage: error.toString(),
        isloading: false,
      ));
    }
  }

  Future<void> delete({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('wishList')
          .doc(documentID)
          .delete();
    } catch (error) {
      emit(
        const WishListState(
          documents: [],
          isloading: true,
          errorMessage: '',
        ),
      );
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
