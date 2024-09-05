import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/domain/models/model_icon_by_type_pokemons.dart';
import 'package:pokemon_app/domain/models/model_type_pokemons.dart';
import 'package:pokemon_app/infraestructure/driven_adapter/api/api_get_pokemons.dart';

class FilterByTypePokemons extends StatefulWidget {
  final int index;
  final bool isVisible;
  const FilterByTypePokemons(
      {super.key, required this.index, required this.isVisible});

  @override
  State<FilterByTypePokemons> createState() => _FilterByTypePokemonsState();
}

class _FilterByTypePokemonsState extends State<FilterByTypePokemons> {
  late Future<ModelTypePokemons> buttonsTypePokemons;
  late ModelIconByTypePokemons labelByTypePokemons;

  // Variable para guardar el índice del chip seleccionado
  int? selectedTypeIndex;

  List selectedList = [];

  @override
  void initState() {
    super.initState();
    buttonsTypePokemons = ApiGetTypePokemons().getButtonsTypePokemons();
    labelByTypePokemons = iconByTypePokemons[widget.index];
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: const Color.fromARGB(40, 206, 204, 204),
          borderRadius: BorderRadius.circular(10),
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
                  ),
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
              return const Center(child: Text('No data available.'));
            }

            final results = snapshot.data!.results;
            return GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
              //padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: results.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilterChip(
                    label: Column(
                      children: [
                        SvgPicture.asset(
                          iconByTypePokemons[index].iconPokemons,
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(height: 10),
                        Text(results[index].name),
                        const SizedBox(height: 10),
                      ],
                    ),
                    selectedColor: Colors.grey,
                    showCheckmark: false,
                    selected: selectedTypeIndex == index,
                    onSelected: (bool selected) async {
                      //var dataTypePokemons = await ApiGetPokemonsByType().getPokemonsByType(index + 1);
                      // setState(() {});
                      //context.push('/cardPage/$index');
                      
                      print('index: $index');

                      setState(() {
                        if (selected) {
                          selectedTypeIndex = index; // Selecciona el nuevo chip
                        } else {
                          selectedTypeIndex =
                              null; // Deselecciona si el usuario hace clic en el mismo chip
                        }
                      });
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
