import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_wish_trip_state.dart';

class AddWishTripCubit extends Cubit<AddWishTripState> {
  AddWishTripCubit() : super(const AddWishTripState());

  Future<void> add(
    String title,
    String imageURL,
  ) async {
    emit(const AddWishTripState(
      saved: true
    ));
  }
}
