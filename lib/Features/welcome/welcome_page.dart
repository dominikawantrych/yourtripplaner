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
