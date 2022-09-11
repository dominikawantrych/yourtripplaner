// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:yourtripplaner/Features/models/item_model.dart';
import 'package:yourtripplaner/repositories/items_repository.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this._itemsRepository) : super(DetailsState(itemModel: null));

  final ItemsRepository _itemsRepository;

  Future<void> getItemWithID(String id) async {
    final itemModel = await _itemsRepository.get(id: id);
    emit(DetailsState(itemModel: itemModel));
  }
}
