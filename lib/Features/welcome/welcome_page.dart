import 'package:flutter/material.dart';
import 'package:yourtripplaner/Features/home/page/home_page.dart';
import 'package:yourtripplaner/Features/weather/pages/weather_page.dart';
import 'package:yourtripplaner/Features/wish_list/wish_list/wish_list.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var currentIndex = 0;

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
        title: const Text('Plan Your Trip '),
      ),
      body: Builder(
        builder: (context) {
          if (currentIndex == 1) {
            return const HomePage();
          }
          if (currentIndex == 2) {
            return const WeatherPage();
          }
          if (currentIndex == 3) {
            return WishList();
          }
          if (currentIndex == 0) {}
          return Column();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        currentIndex: currentIndex,
        onTap: (newIndex) {
          setState(() {
            currentIndex = newIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Welcome',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sunny_snowing),
            label: 'Weather',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Wish List',
          ),
        ],
      ),
    );
  }
}
