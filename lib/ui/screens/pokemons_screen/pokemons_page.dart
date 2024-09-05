// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/infraestructure/driven_adapter/api/api_get_pokemons.dart';
import 'package:pokemon_app/domain/models/model_icon_by_type_pokemons.dart';
import 'package:pokemon_app/domain/models/model_type_pokemons.dart';
import 'package:pokemon_app/ui/screens/pokemons_screen/widgets/filter_by_type_pokemons.dart';
import 'package:pokemon_app/ui/screens/pokemons_screen/widgets/list_type_pokemon.dart';

class PokemonsPage extends StatefulWidget {
  const PokemonsPage({super.key});

  @override
  State<PokemonsPage> createState() => _PokemonsPageState();
}

class _PokemonsPageState extends State<PokemonsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        const FilterChipExample(
          index: 0,
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

enum PokemonsFilter { types, running, cycling, hiking }

class FilterChipExample extends StatefulWidget {
  final int index;
  const FilterChipExample({super.key, required this.index});

  @override
  State<FilterChipExample> createState() => _FilterChipExampleState();
}

class _FilterChipExampleState extends State<FilterChipExample> {
  Set<PokemonsFilter> filters = <PokemonsFilter>{};

  late Future<ModelTypePokemons> buttonsTypePokemons;
  late ModelIconByTypePokemons labelByTypePokemons;
  void initState() {
    super.initState();
    buttonsTypePokemons = ApiGetTypePokemons().getButtonsTypePokemons();
    labelByTypePokemons = iconByTypePokemons[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    bool isVisible = true;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Choose one', style: textTheme.labelLarge),
          const SizedBox(height: 5.0),
          Wrap(
            spacing: 5.0,
            children: PokemonsFilter.values.map((PokemonsFilter types) {
              return FilterChip(
                label: Text(types.name),
                selected: filters.contains(types),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      filters.add(types);
                      isVisible;
                    } else {
                      filters.remove(types);
                      !isVisible;
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 10.0),
          // Text(
          //   'Looking for: ${filters.map((PokemonsFilter e) => e.name).join(', ')}',
          //   style: textTheme.labelLarge,
          // ),
          FilterByTypePokemons(index: 0, isVisible: filters.contains(PokemonsFilter.types)),
          // Visibility(
          //   visible: filters.contains(PokemonsFilter.types),
          //   child: Container(
          //     height: MediaQuery.of(context).size.height * 0.13,
          //     width: MediaQuery.of(context).size.width,
          //     margin: const EdgeInsets.all(10),
          //     padding: const EdgeInsets.all(3),
          //     decoration: const BoxDecoration(
          //         color: Color.fromARGB(101, 158, 158, 158),
          //         borderRadius: BorderRadius.all(Radius.circular(10))),
          //     child: FutureBuilder<ModelTypePokemons>(
          //       future: buttonsTypePokemons,
          //       builder: (context, snapshot) {
          //         if (snapshot.connectionState == ConnectionState.waiting) {
          //           return const Center(child: CircularProgressIndicator());
          //         }
          //         if (snapshot.hasError) {
          //           return Center(
          //               child: Card(
          //                   child: Padding(
          //             padding: const EdgeInsets.all(12.0),
          //             child: Text("Error: ${snapshot.error}"),
          //           )));
          //         } else {
          //           return GridView.builder(
          //             scrollDirection: Axis.horizontal,
          //             gridDelegate:
          //                 const SliverGridDelegateWithFixedCrossAxisCount(
          //                     crossAxisCount: 1),
          //             itemCount: snapshot.data?.results.length,
          //             itemBuilder: (context, index) {
          //               return GestureDetector(
          //                 onTap: () async {
          //                   var dataTypePokemons = await ApiGetPokemonsByType()
          //                       .getPokemonsByType(index + 1);
          //                   setState(() {});
          //                   context.push('/cardPage/$index');
          //                   print("dataTypePokemons: $dataTypePokemons");
          //                 },
          //                 child: Card(
          //                   child: GridTile(
          //                     child: Column(
          //                       mainAxisAlignment: MainAxisAlignment.center,
          //                       children: [
          //                         const SizedBox(height: 10),
          //                         Expanded(
          //                           child: SvgPicture.asset(
          //                             iconByTypePokemons[index].iconPokemons,
          //                             // width: 30,
          //                             // height: 30,
          //                           ),
          //                         ),
          //                         const SizedBox(height: 10),
          //                         Text("${snapshot.data?.results[index].name}"),
          //                         const SizedBox(height: 10),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               );
          //             },
          //           );
          //         }
          //       },
          //     ),
          //   ),
          // ),
          const SizedBox(height: 10),
          Visibility(
            visible: filters.contains(PokemonsFilter.types),
            child: Container(
              //height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(101, 158, 158, 158),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(labelByTypePokemons.labelIconPokemons),
                    ),
                  ]),
                ),
                const SizedBox(height: 10),
                Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(185, 91, 190, 98),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: ListTypePokemon(index: widget.index))
              ]),
            ),
          )
        
        ],
      ),
    );
  }
}
