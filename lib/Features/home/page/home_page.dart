import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourtripplaner/Features/add/page/add_page.dart';
import 'package:yourtripplaner/Features/details/pages/details_page.dart';
import 'package:yourtripplaner/Features/home/cubit/home_cubit.dart';

import 'package:yourtripplaner/Features/models/item_model.dart';

import 'package:yourtripplaner/repositories/items_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => HomeCubit(ItemsRepository())..start(),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                final itemModels = state.items;
                if (itemModels.isEmpty) {
                  return const SizedBox.shrink();
                }
                if (state.loadingErrorOccured) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  children: [
                    for (final itemModel in itemModels) ...[
                      Dismissible(
                        key: ValueKey(itemModel.id),
                        background: const DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.red,
                          ),
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 32),
                                child: Icon(
                                  Icons.delete,
                                ),
                              )),
                        ),
                        confirmDismiss: (direction) async {
                          return direction == DismissDirection.endToStart;
                        },
                        onDismissed: (direction) {
                          context
                              .read<HomeCubit>()
                              .remove(documentID: itemModel.id);
                        },
                        child: ListViewItem(
                          itemModel: itemModel,
                        ),
                      ),
                    ],
                  ],
                );
              },
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const AddPage()));
          },
          child: const Icon(Icons.add),
        ));
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
                borderRadius: BorderRadius.all(
                  Radius.circular(32),
                ),
                color: Colors.black12,
              ),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(32),
                      ),
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
