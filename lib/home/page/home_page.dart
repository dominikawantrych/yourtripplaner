import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan Your Trip'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('trip').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Problem has occured');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading');
            }

            final documents = snapshot.data!.docs;

            return ListView(
              children: [
                for (final document in documents) ...[
                  Dismissible(
                    key: ValueKey(document.id),
                    onDismissed: (_) {
                      FirebaseFirestore.instance
                          .collection('trip')
                          .doc(document.id)
                          .delete();
                    },
                    child: ListViewItem(document['title']),
                  ),
                ],
              ],
            );
          }),
    );
  }
}

class ListViewItem extends StatelessWidget {
  const ListViewItem(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      child: Text(title),
    );
  }
}