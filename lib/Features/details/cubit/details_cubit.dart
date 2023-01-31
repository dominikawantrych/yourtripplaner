// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:yourtripplaner/Features/models/details_model.dart';
import 'package:yourtripplaner/app/core/enums.dart';
import 'package:yourtripplaner/repositories/details_repository.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this._detailsRepository)
      : super(DetailsState(
          docs: [],
          errorMessage: '',
          status: Status.initial,
        ));

  final DetailsRepository _detailsRepository;

  StreamSubscription? _streamSubscription;

  Future<void> start() async {
    emit(DetailsState(
      docs: [],
      errorMessage: '',
      status: Status.loading,
    ));

    _streamSubscription = _detailsRepository.getDetailsStream().listen((docs) {
      final detailsModels = docs;
      emit(
        DetailsState(
          docs: detailsModels,
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

  Future<void> add({required String title}) async {
    try {
      await _detailsRepository.add(title);
      emit(DetailsState(
        docs: state.docs,
        errorMessage: '',
        status: Status.success,
      ));
    } catch (error) {
      emit(DetailsState(
        errorMessage: error.toString(),
        docs: [],
        status: Status.error,
      ));
    }
  }

  Future<void> remove({required String documentID}) async {
    try {
      await _detailsRepository.delete(id: documentID);
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
