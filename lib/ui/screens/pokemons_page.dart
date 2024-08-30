// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/infraestructure/driven_adapter/api/api_get_pokemons.dart';
import 'package:pokemon_app/domain/models/model_icon_by_type_pokemons.dart';
import 'package:pokemon_app/domain/models/model_type_pokemons.dart';
import 'package:pokemon_app/ui/screens/list_type_pokemon.dart';

class PokemonsPage extends StatefulWidget {
  const PokemonsPage({super.key});

  @override
  State<PokemonsPage> createState() => _PokemonsPageState();
}

class _PokemonsPageState extends State<PokemonsPage> {
  // late Future<ModelTypePokemons> buttonsTypePokemons;

  // @override
  // void initState() {
  //   super.initState();
  //   buttonsTypePokemons = ApiGetTypePokemons().getButtonsTypePokemons();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),
        const FilterChipExample(index: 0,),
        const SizedBox(height: 30),
        // Container(
        //   height: MediaQuery.of(context).size.height * 0.2,
        //   width: MediaQuery.of(context).size.width,
        //   margin: const EdgeInsets.all(10),
        //   color: Colors.grey,
        //   child: FutureBuilder<ModelTypePokemons>(
        //     future: buttonsTypePokemons,
        //     builder: (context, snapshot) {
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return const Center(child: CircularProgressIndicator());
        //       }
        //       if (snapshot.hasError) {
        //         return Center(
        //             child: Card(
        //                 child: Padding(
        //           padding: const EdgeInsets.all(12.0),
        //           child: Text("Error: ${snapshot.error}"),
        //         )));
        //       } else {
        //         return ListView.builder(
        //           itemCount: snapshot.data?.results.length,
        //           itemBuilder: (context, index) {
        //             return Card(
        //               child: ListTile(
        //                 leading: SvgPicture.asset(
        //                     iconByTypePokemons[index].iconPokemons,
        //                     width: 30,
        //                     height:
        //                         30), //leading: SvgPicture.asset(iconByTypePokemons[index].iconPokemons, width: 30, height: 30),
        //                 title: Text("${snapshot.data?.results[index].name}"),
        //                 trailing: IconButton(
        //                   icon: const Icon(Icons.chevron_right),
        //                   onPressed: () async {
        //                     var dataTypePokemons = await ApiGetPokemonsByType()
        //                         .getPokemonsByType(index + 1);
        //                     setState(() {});
        //                     context.push('/cardPage/$index');
        //                     print("dataTypePokemons: $dataTypePokemons");
        //                   },
        //                 ),
        //               ),
        //             );
        //           },
        //         );
        //       }
        //     },
        //   ),
        // ),
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
            children: PokemonsFilter.values.map((PokemonsFilter exercise) {
              return FilterChip(
                label: Text(exercise.name),
                selected: filters.contains(exercise),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      filters.add(exercise);
                      isVisible;
                    } else {
                      filters.remove(exercise);
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

          Visibility(
            visible: filters.contains(PokemonsFilter.types),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Color.fromARGB(101, 158, 158, 158),
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
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
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4),
                      itemCount: snapshot.data?.results.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            var dataTypePokemons = await ApiGetPokemonsByType()
                                .getPokemonsByType(index + 1);
                            setState(() {});
                            context.push('/cardPage/$index');
                            print("dataTypePokemons: $dataTypePokemons");
                          },
                          child: Card(
                            child: GridTile(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: SvgPicture.asset(
                                      iconByTypePokemons[index].iconPokemons,
                                      // width: 30,
                                      // height: 30,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text("${snapshot.data?.results[index].name}"),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            //height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Color.fromARGB(101, 158, 158, 158),
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
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
                      ]
                    ),
                    
                  ),
                  SizedBox(height: 10),
                  Container(
                    //height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(185, 91, 190, 98),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    //child: ListTypePokemon(index: 0)
                  )
                ]
              ),
          )
        ],
      ),
    );
  }
}
