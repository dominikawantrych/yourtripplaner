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
                onPressed: () {},
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://s1.tvp.pl/images2/1/3/2/uid_132ea16d61e69d3c68c4175d0ed282521647714312176_width_1280_play_0_pos_0_gs_0_height_720_bazylika-sagrada-familia-antonio-gaudiego-w-barcelonie-fot-shutterstock.jpg'))),
          )
        ],
      ),
    );
  }
}
