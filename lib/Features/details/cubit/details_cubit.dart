// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit()
      : super(DetailsState(
          docs: [],
          errorMessage: '',
          isLoading: false,
        ));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(DetailsState(
      docs: [],
      errorMessage: '',
      isLoading: true,
    ));

    _streamSubscription = FirebaseFirestore.instance
        .collection('todo')
        .snapshots()
        .listen((data) {
      emit(
        DetailsState(
          docs: data.docs,
          isLoading: false,
          errorMessage: '',
        ),
      );
    })
      ..onError((error) {
        emit(
          DetailsState(
            docs: [],
            isLoading: false,
            errorMessage: '',
          ),
        );
      });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
