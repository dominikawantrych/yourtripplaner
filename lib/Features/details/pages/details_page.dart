import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourtripplaner/Features/details/cubit/details_cubit.dart';

import 'package:yourtripplaner/Features/models/item_model.dart';
import 'package:yourtripplaner/repositories/items_repository.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({
    required this.id,
    Key? key,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plan Your Trip'),
        ),
        body: BlocProvider(
            create: (context) =>
                DetailsCubit(ItemsRepository())..getItemWithID(id),
            child: BlocBuilder<DetailsCubit, DetailsState>(
                builder: (context, state) {
              final itemModel = state.itemModel;
              if (itemModel == null) {
                return const CircularProgressIndicator();
              }

              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  ListViewItem(itemModel: itemModel),
                ],
              );
            })));
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsPage(id: itemModel.id),
        ));
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 30,
          ),
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.black12,
              ),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      image: DecorationImage(
                        image: NetworkImage(
                          itemModel.imageURL,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                itemModel.title,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                itemModel.dateFormatted(),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                        ),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              itemModel.daysLeft(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text('days left'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }
}
