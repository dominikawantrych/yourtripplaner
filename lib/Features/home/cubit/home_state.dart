part of 'home_cubit.dart';

@immutable
class HomeState {
 const HomeState({
    this.items,
    this.loadingErrorOccured = false,
    this.removingErrorOccured = false,
  });
  final QuerySnapshot<Map<String, dynamic>>? items;
  final bool loadingErrorOccured;
  final bool removingErrorOccured;
}
