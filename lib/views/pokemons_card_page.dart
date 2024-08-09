import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:pokemon_app/controllers/services/api/api_get_pokemons.dart';
import 'package:pokemon_app/models/model_by_type_pokemons.dart';
import 'package:pokemon_app/models/model_details_pokemons.dart';
import 'package:pokemon_app/models/model_icon_by_type_pokemons.dart';

class PokemonsCardPage extends StatefulWidget {
  final int index;
  const PokemonsCardPage({super.key, required this.index});

  @override
  State<PokemonsCardPage> createState() => _PokemonsCardPageState();
}

class _PokemonsCardPageState extends State<PokemonsCardPage> {
  final CardSwiperController controller = CardSwiperController();

  late Future<ModelByTypePokemons> typePokemons;
  late Future<ModelDetailsPokemons> detailsPokemons;
  late ModelIconByTypePokemons labelByTypePokemons;

  @override
  void initState() {
    super.initState();
    typePokemons = ApiGetPokemonsByType().getPokemonsByType(widget.index + 1);

    // Obtener el icono y etiqueta del tipo de Pokémon correspondiente
    labelByTypePokemons = iconByTypePokemons[widget
        .index]; //labelByTypePokemons = iconByTypePokemons[widget.index] ?? iconByTypePokemons.last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(labelByTypePokemons.labelIconPokemons),
      ),
      body: SafeArea(
        child: FutureBuilder<ModelByTypePokemons>(
          future: typePokemons,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return ListView.builder(
                  itemCount: snapshot.data?.pokemon?.length,
                  itemBuilder: (context, index) {
                    detailsPokemons = ApiGetDetailsPokemons()
                        .getDetailsPokemons(
                            snapshot.data?.pokemon?[index].pokemon?.url ?? '');
                    return Dismissible(
                      key: Key(
                          '${snapshot.data!.pokemon![index].pokemon!.name}'),
                      background: Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.green,
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text("Equip"),
                        ),
                      ),
                      direction: DismissDirection.startToEnd,
                      child: ExpansionTile(
                        leading: FutureBuilder<ModelDetailsPokemons>(
                          future: detailsPokemons,
                          builder: (context, pokeImg) {
                            if (pokeImg.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (pokeImg.hasError) {
                              return Text('Error: ${pokeImg.error}');
                            } else {
                              String? url = pokeImg.data!.sprites!.other!
                                  .officialArtwork!.frontDefault;

                              return url != null
                                  ? CachedNetworkImage(
                                    imageUrl: url,
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                  : SvgPicture.asset(
                                      'assets/image_not_found.svg');
                            }
                          },
                        ),
                        title: Text(
                            "${snapshot.data!.pokemon![index].pokemon?.name}"),
                        trailing: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                                color: Color(0xffece5f3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: const Text(
                              'view',
                              style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold),
                            )),
                        children: [
                          FutureBuilder<ModelDetailsPokemons>(
                            future: detailsPokemons,
                            builder: (context, pokeImg) {
                              if (pokeImg.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text('Cargando...');
                              } else if (pokeImg.hasError) {
                                return Text('Error: ${pokeImg.error}');
                              } else {
                                return Column(
                                  children: [
                                    Container(
                                      height: 200,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xff343434),
                                        //color: Color(0xffebeceb),
                                        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                                      ),
                                      child: Text("${pokeImg.data!.name}"),
                                      ),
                                    
                                  ],
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
