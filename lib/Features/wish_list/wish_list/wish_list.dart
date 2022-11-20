import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class WishList extends StatelessWidget {
  WishList({
    Key? key,
  }) : super(key: key);
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  FirebaseFirestore.instance
                      .collection('wishList')
                      .add({'imageURL': controller.text});
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
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: FirebaseFirestore.instance.collection('wishList').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading');
            }
            final documents = snapshot.data!.docs;

            return GridView.count(
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                  for (final document in documents) ...[
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            document['imageURL'],
                          ),
                        ),
                      ),
                    )
                  ],
                ]);
          }),
    );
  }
}
