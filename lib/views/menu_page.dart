// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/controllers/services/api/api_get_pokemons.dart';
import 'package:pokemon_app/models/model_type_pokemons.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late Future<ModelTypePokemons> buttonsTypePokemons;

   
  @override
  void initState() {
    super.initState();
    buttonsTypePokemons = ApiGetTypePokemons().getButtonsTypePokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokemons"),
      ),
      body: FutureBuilder<ModelTypePokemons>(
        future: buttonsTypePokemons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Card(
                    child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Error: ${snapshot.error}"),
            )));
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.results.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("${snapshot.data?.results[index].name}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () async {
                        var dataTypePokemons = await ApiGetPokemons().getPokemons(index + 1);
                        setState(() {});
                        context.push('/cardPage/$index');
                        print("dataTypePokemons: $dataTypePokemons");
                        
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
