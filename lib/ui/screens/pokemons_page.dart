// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/infraestructure/driven_adapter/api/api_get_pokemons.dart';
import 'package:pokemon_app/domain/models/model_icon_by_type_pokemons.dart';
import 'package:pokemon_app/domain/models/model_type_pokemons.dart';

class PokemonsPage extends StatefulWidget {
  const PokemonsPage({super.key});

  @override
  State<PokemonsPage> createState() => _PokemonsPageState();
}

class _PokemonsPageState extends State<PokemonsPage> {
  late Future<ModelTypePokemons> buttonsTypePokemons;
  //final OverlayPortalController _tooltipController = OverlayPortalController();

  @override
  void initState() {
    super.initState();
    buttonsTypePokemons = ApiGetTypePokemons().getButtonsTypePokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const SizedBox(height: 30),
          const FilterChipExample(),
          const SizedBox(height: 30),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            color: const Color.fromARGB(255, 221, 18, 18),
          ),
          const SizedBox(height: 30),
          const Text("Equip Pokemon"),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            color: Colors.grey,
            child: FutureBuilder<ModelTypePokemons>(
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
                          leading: SvgPicture.asset(
                              iconByTypePokemons[index].iconPokemons,
                              width: 30,
                              height:
                                  30), //leading: SvgPicture.asset(iconByTypePokemons[index].iconPokemons, width: 30, height: 30),
                          title:
                              Text("${snapshot.data?.results[index].name}"),
                          trailing: IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: () async {
                              var dataTypePokemons =
                                  await ApiGetPokemonsByType()
                                      .getPokemonsByType(index + 1);
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
          ),
        ],
      );
  }


  
}

enum ExerciseFilter { walking, running, cycling, hiking }

class FilterChipExample extends StatefulWidget {
  const FilterChipExample({super.key});

  @override
  State<FilterChipExample> createState() => _FilterChipExampleState();
}

class _FilterChipExampleState extends State<FilterChipExample> {
  Set<ExerciseFilter> filters = <ExerciseFilter>{};

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Choose one', style: textTheme.labelLarge),
          const SizedBox(height: 5.0),
          Wrap(
            spacing: 5.0,
            children: ExerciseFilter.values.map((ExerciseFilter exercise) {
              return FilterChip(
                label: Text(exercise.name),
                selected: filters.contains(exercise),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      filters.add(exercise);
                    } else {
                      filters.remove(exercise);
                    }
                  });
                },
              );
            }).toList(),
          ),
          // const SizedBox(height: 10.0),
          // Text(
          //   'Looking for: ${filters.map((ExerciseFilter e) => e.name).join(', ')}',
          //   style: textTheme.labelLarge,
          // ),
        ],
      ),
    );
  }
}