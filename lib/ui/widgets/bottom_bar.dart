import 'package:flutter/material.dart';
import 'package:pokemon_app/ui/screens/berries_page.dart';
import 'package:pokemon_app/ui/screens/items_page.dart';
import 'package:pokemon_app/ui/screens/menu_page.dart';
import 'package:pokemon_app/ui/screens/pokemons_screen/pokemons_page.dart';
import 'package:pokemon_app/ui/screens/preferences_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int currentPageIndex = 3;

  final List<Map<String, dynamic>> barItems = const [
    {
      'title': 'Berries',
      'icon': 'assets/png/berry_pk.png',
      'iconBar': 'assets/png/berry_pk.png',
      'color': Color(0xff6077ff),
      'screen': BerriesPage(),
    },
    {
      'title': 'Items',
      'icon': 'assets/png/item_pk.png',
      'iconBar': 'assets/png/item_pkx.png',
      'color': Color(0xffd19a19),
      'screen': ItemsPage(),
    },
    {
      'title': 'Home',
      'icon': 'assets/png/icon_pokeball.png',
      'iconBar': 'assets/png/icon_pokeballx.png',
      'color': Color(0xffc5232c),
      'screen': MenuPage(),
    },
    {
      'title': 'Pokemons',
      'icon': 'assets/png/icon_bulbasaur_pk.png',
      'iconBar': 'assets/png/icon_bulbasaur_pk.png',
      'color': Color(0xff11b800),
      'screen': PokemonsPage(),
    },
    {
      'title': 'Settings',
      'icon': 'assets/png/magneton_pk.png',
      'iconBar': 'assets/png/magneton_pk.png',
      'color': Color(0xff6b6b6b),
      'screen': PreferencesPage(),
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentItem = barItems[currentPageIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: currentItem['color'],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        toolbarHeight: 60,
        leading: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset(currentItem['icon']),
        ),
        title: Text(
          currentItem['title'],
          style: const TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: IndexedStack(
          index: currentPageIndex,
          children: barItems.map((item) => item['screen'] as Widget).toList(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: barItems
            .map((item) => BottomNavigationBarItem(
                  icon: Image.asset(item['iconBar']),
                  label: item['title'],
                  backgroundColor: item['color'],
                ))
            .toList(),
        currentIndex: currentPageIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
