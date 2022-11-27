part of 'add_wish_trip_cubit.dart';

@immutable
 class AddWishTripState {
  const AddWishTripState({
    this.saved = false,
    this.errorMessage = '',
  });

  final bool saved;
  final String errorMessage;
 }


