import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipes_app/screens/home_screen/home_screen.dart';
import 'package:recipes_app/screens/second_screen/second_screen.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final pages = [
    const HomeScreen(),
    const SecondScreen(),
    const SecondScreen(),
    const SecondScreen(),
    const SecondScreen()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: (context, index, _) {
            return IndexedStack(index: index, children: pages);
          }),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int newIndex, _) {
          return BottomNavigationBar(
              currentIndex: newIndex,
              onTap: (index) {
                indexChangeNotifier.value = index;
              },
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Colors.orange,
              selectedLabelStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              selectedIconTheme: const IconThemeData(color: Colors.orange),
              unselectedIconTheme: const IconThemeData(
                  color: Color.fromARGB(255, 138, 138, 138)),
              items: const [
                BottomNavigationBarItem(
                    icon: FaIcon(
                      FontAwesomeIcons.utensils,
                      size: 22,
                    ),
                    label: 'Recipes'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.list_alt_outlined, size: 25),
                    label: 'List'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.s), label: 'Nosh'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today, size: 21),
                    label: 'Meal Plan'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person, size: 22), label: 'Profile'),
              ]);
        },
      ),
    );
  }
}
