// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yourtripplaner/repositories/wish_repository.dart';

part 'add_wish_trip_state.dart';

class AddWishTripCubit extends Cubit<AddWishTripState> {
  AddWishTripCubit(this._wishRepository) : super(const AddWishTripState());

  final WishRepository _wishRepository;

  Future<void> add(
    String title,
    String imageURL,
  ) async {
    try {
      await _wishRepository.add(title: title, imageURL: imageURL);
      emit(const AddWishTripState(saved: true));
    } catch (error) {
      emit(AddWishTripState(errorMessage: error.toString()));
    }
    
  }
}
