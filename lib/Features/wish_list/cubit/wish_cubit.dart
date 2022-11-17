import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'wish_state.dart';

class WishCubit extends Cubit<WishState> {
  WishCubit()
      : super(const WishState(
          documents: [],
          errorMessage: '',
          isLoading: false,
        ));

  Future<void> start() async {
    emit(
      const WishState(
        documents: [],
        isLoading: true,
        errorMessage: '',
      ),
    );
  }
}
