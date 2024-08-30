import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:pokemon_app/ui/screens/menu_page.dart';
import 'package:pokemon_app/ui/screens/pokemons_card_page.dart';
import 'package:pokemon_app/ui/screens/start_page.dart';
import 'package:pokemon_app/ui/widgets/bottom_bar.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return StartPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'menuPage',
          builder: (BuildContext context, GoRouterState state) {
            return const BottomBar();
          },
        ),
        // GoRoute(
        //   path: 'menuPage',
        //   builder: (BuildContext context, GoRouterState state) {
        //     return const MenuPage();
        //   },
        // ),
        GoRoute(
          path: 'cardPage/:index',
          builder: (BuildContext context, GoRouterState state) {
            final index = int.parse(state.pathParameters['index']!);
            return PokemonsCardPage(
              index: index,
            );
          },
        ),
      ],
    ),
  ],
);

/// The details screen
class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen]
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Go back to the Home screen'),
        ),
      ),
    );
  }
}
