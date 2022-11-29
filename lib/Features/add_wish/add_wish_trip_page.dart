import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourtripplaner/Features/add_wish/cubit/add_wish_trip_cubit.dart';

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
      create: (context) => AddWishTripCubit(),
      child: BlocBuilder<AddWishTripCubit, AddWishTripState>(
        builder: (context, state) {
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
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color.fromARGB(255, 141, 193, 242),
                      Color.fromARGB(255, 173, 211, 248),
                      Color.fromARGB(255, 187, 217, 246),
                      Color.fromARGB(255, 202, 226, 250),
                      Color.fromARGB(255, 200, 222, 244),
                      Color.fromARGB(255, 209, 223, 235),
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
