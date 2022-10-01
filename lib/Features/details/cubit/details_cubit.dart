// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourtripplaner/Features/models/details_model.dart';
import 'package:yourtripplaner/app/core/enums.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit()
      : super(DetailsState(
          docs: [],
          errorMessage: '',
          status: Status.initial,
        ));

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(DetailsState(
      docs: [],
      errorMessage: '',
      status: Status.loading,
    ));

    _streamSubscription = FirebaseFirestore.instance
        .collection('todo')
        .snapshots()
        .listen((docs) {
      final detailsModel = docs.docs.map((docs) {
        return DetailsModel(id: docs['id'], title: docs['title']);
      }).toList();
      emit(
        DetailsState(
          docs: detailsModel,
          errorMessage: '',
          status: Status.success,
        ),
      );
    })
      ..onError((error) {
        emit(
          DetailsState(
            docs: [],
            status: Status.error,
            errorMessage: error.toString(),
          ),
        );
      });
  }

  Future<void> remove({required String documentID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('todo')
          .doc(documentID)
          .delete();
    } catch (error) {
      emit(DetailsState(
        errorMessage: error.toString(),
      ));
      start();
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
