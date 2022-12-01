import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:yourtripplaner/Features/models/wish_model.dart';
import 'package:yourtripplaner/repositories/wish_repository.dart';

part 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  WishListCubit(this._wishRepository)
      : super(const WishListState(
          documents: [],
          errorMessage: '',
          isloading: false,
        ));
  final WishRepository _wishRepository;
  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(const WishListState(
      documents: [],
      errorMessage: '',
      isloading: true,
    ));

    _streamSubscription = _wishRepository.getWishStream()
        .listen((data) {
      
      emit(
        WishListState(
          documents: data,
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
      await _wishRepository.add(imageURL: imageURL, title: title);
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
     _wishRepository.delete(documentID: documentID);
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
