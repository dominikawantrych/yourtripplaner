import 'package:flutter/material.dart';

class WishList extends StatelessWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color.fromARGB(255, 38, 132, 221),
                Color.fromARGB(255, 69, 156, 237),
                Color.fromARGB(255, 83, 163, 238),
                Color.fromARGB(255, 137, 185, 231),
                Color.fromARGB(255, 145, 181, 214),
                Color.fromARGB(255, 198, 219, 238),
              ],
            ),
          ),
        ),
        title: const Text('Wish List'),
      ),
    );
  }
}
