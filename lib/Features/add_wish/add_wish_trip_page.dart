import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourtripplaner/Features/add_wish/cubit/add_wish_trip_cubit.dart';
import 'package:yourtripplaner/data/remote_data_sources/wish_remote_data_source.dart';
import 'package:yourtripplaner/repositories/wish_repository.dart';

class AddWishTrip extends StatefulWidget {
  const AddWishTrip({Key? key}) : super(key: key);

  @override
  State<AddWishTrip> createState() => _AddWishTripState();
}

class _AddWishTripState extends State<AddWishTrip> {
  String? imageURL;

  String? title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddWishTripCubit(WishRepository(WishRemoteDataSource())),
      child: BlocConsumer<AddWishTripCubit, AddWishTripState>(
        listener: (context, state) {
        if (state.saved) {
            Navigator.of(context).pop();
          }
           if (state.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage),
                backgroundColor: Colors.red,
              ),
            );
          }
      },
        builder: (context, state) {
         
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color.fromARGB(255, 118, 178, 233),
                      Color.fromARGB(255, 173, 211, 248),
                      Color.fromARGB(255, 187, 217, 246),
                      Color.fromARGB(255, 202, 226, 250),
                      Color.fromARGB(255, 216, 231, 246),
                      Color.fromARGB(255, 226, 234, 241),
                    ],
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
              title: const Text('Add to Wish List'),
              actions: [
                IconButton(
                  onPressed: imageURL == null || title == null
                      ? null
                      : () {
                          context.read<AddWishTripCubit>().add(
                                title!,
                                imageURL!,
                              );
                        },
                  icon: const Icon(Icons.check),
                ),
              ],
            ),
            body: AddWishTripBody(
              onTitleChanged: (newValue) {
                setState(() {
                  title = newValue;
                });
              },
              onImageUrlChanged: (newValue) {
                setState(() {
                  imageURL = newValue;
                });
              },
            ),
          );
        },
      ),
    );
  }
}

class AddWishTripBody extends StatelessWidget {
  const AddWishTripBody({
    Key? key,
    required this.onTitleChanged,
    required this.onImageUrlChanged,
  }) : super(key: key);

  final Function(String) onTitleChanged;
  final Function(String) onImageUrlChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        children: [
          TextField(
            onChanged: onTitleChanged,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Spain',
              label: Text('Title'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: onImageUrlChanged,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'http:// ... .jpg',
              label: Text('Image URL'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ]);
  }
}
