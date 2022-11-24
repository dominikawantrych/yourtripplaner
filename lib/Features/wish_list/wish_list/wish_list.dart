import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import 'package:yourtripplaner/Features/wish_list/cubit/wish_list_cubit.dart';

class WishList extends StatelessWidget {
  WishList({
    Key? key,
  }) : super(key: key);
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishListCubit(),
      child: BlocBuilder<WishListCubit, WishListState>(
        builder: (context, state) {
          return Scaffold(
            bottomSheet: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                heightFactor: 0.5,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: 'Add photo url...',
                          icon: const Icon(
                            Ionicons.image_outline,
                            color: Colors.blue,
                          ),
                        ).copyWith(
                          hintStyle: const TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        context
                            .read<WishListCubit>()
                            .add(imageURL: controller.text);
                        controller.clear;
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: BlocProvider(
              create: (context) => WishListCubit()..start(),
              child: BlocBuilder<WishListCubit, WishListState>(
                builder: (context, state) {
                  final wishModels = state.documents;

                  if (wishModels.isNotEmpty) {
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
                              
                            ),
                          )
                        ],
                      ]);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
