import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:yourtripplaner/Features/add_wish/add_wish_trip_page.dart';
import 'package:yourtripplaner/Features/wish_list/cubit/wish_list_cubit.dart';
import 'package:yourtripplaner/data/remote_data_sources/wish_remote_data_source.dart';
import 'package:yourtripplaner/repositories/wish_repository.dart';

class WishList extends StatelessWidget {
  WishList({
    Key? key,
  }) : super(key: key);
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            WishListCubit(WishRepository(WishRemoteDataSource()))..start(),
        child: BlocBuilder<WishListCubit, WishListState>(
          builder: (context, state) {
            final wishModels = state.documents;

            if (wishModels.isEmpty) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            if (state.isloading) {
              return const Center(child: CircularProgressIndicator());
            }

            return GridView.count(
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  for (final wishModel in wishModels) ...[
                    Dismissible(
                      key: ValueKey(wishModel.id),
                      onDismissed: (_) {
                        context
                            .read<WishListCubit>()
                            .delete(documentID: wishModel.id);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: NetworkImage(
                              wishModel.imageURL,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Text(
                          wishModel.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            backgroundColor: Colors.black26,
                          ),
                        ),
                      ),
                    ),
                  ],
                ]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddWishTrip(),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 150, 196, 233),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
