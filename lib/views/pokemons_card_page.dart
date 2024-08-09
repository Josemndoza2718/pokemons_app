import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemon_app/controllers/services/api/api_get_pokemons.dart';
import 'package:pokemon_app/models/model_by_type_pokemons.dart';
import 'package:pokemon_app/models/model_details_pokemons.dart';

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

  @override
  void initState() {
    super.initState();
    typePokemons = ApiGetPokemonsByType().getPokemonsByType(widget.index + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                return const CircularProgressIndicator();
                              } else if (pokeImg.hasError) {
                                return Text('Error: ${pokeImg.error}');
                              } else {
                                return Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.blue,
                                  ),
                                  child: Text("${pokeImg.data!.abilities}"),
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

// class PokemonsListCardPage extends StatefulWidget {
//   const PokemonsListCardPage({super.key, required this.modelPokemons});

//   final ModelPokemons modelPokemons;

//   @override
//   State<PokemonsListCardPage> createState() => _PokemonsListCardPageState();
// }

// class _PokemonsListCardPageState extends State<PokemonsListCardPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Card(
//           color: Colors.amber,
//           borderOnForeground: true,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 300,
//                 height: 530,
//                 margin: const EdgeInsets.all(10),
//                 decoration: const BoxDecoration(color: Colors.red),
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: EdgeInsets.all(10.0),
//                         child: Row(
//                           children: [
//                             Text("${widget.modelPokemons.types}"),
//                           ],
//                         ),
//                       ),
//                       Container(
//                           width: 250,
//                           height: 180,
//                           decoration: BoxDecoration(
//                               color: Colors.blue,
//                               border: Border.all(
//                                   width: 6, color: const Color(0xffc2a625))),
//                           child: Image.network(
//                             "${widget.modelPokemons.sprites}",
//                             fit: BoxFit.cover,
//                           )),
//                       Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           child: const Text(
//                             '''Nisi consectetur irure et culpa excepteur in consectetur occaecat velit minim dolore. Quis ea est consectetur ad deserunt nostrud et. Qui ea qui velit ullamco esse. Eiusmod aute deserunt enim aliquip id incididunt. ''',
//                             textAlign: TextAlign.justify,
//                           )),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Divider(color: Colors.black),
//                       ),
//                       Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           child: const Text(
//                             '''Nisi consectetur irure et culpa excepteur in consectetur occaecat velit minim dolore. Quis ea est consectetur ad deserunt nostrud et. ''',
//                             textAlign: TextAlign.justify,
//                           )),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Divider(color: Colors.black),
//                       ),
//                       Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 15),
//                           child: const Text(
//                             '''Nisi consectetur irure et culpa excepteur in consectetur occaecat velit minim dolore. ''',
//                             textAlign: TextAlign.justify,
//                           )),
//                     ]),
//               )
//             ],
//           ),
//         ),
//         //const SizedBox(height: 20),
//         // Row(
//         //   mainAxisAlignment: MainAxisAlignment.center,
//         //   children: [
//         //     FilledButton(
//         //         style: const ButtonStyle(
//         //           fixedSize: WidgetStatePropertyAll(Size(100, 70)),
//         //           shape: WidgetStatePropertyAll(
//         //               CircleBorder(eccentricity: 0.1)),
//         //           backgroundColor: WidgetStatePropertyAll(
//         //               Color.fromARGB(255, 76, 175, 80)),
//         //         ),
//         //         onPressed: () {},
//         //         child: const Text('Equip')),
//         //     FilledButton(
//         //         style: const ButtonStyle(
//         //           fixedSize: WidgetStatePropertyAll(Size(100, 70)),
//         //           shape: WidgetStatePropertyAll(
//         //               CircleBorder(eccentricity: 0.1)),
//         //           backgroundColor: WidgetStatePropertyAll(Colors.amber),
//         //         ),
//         //         onPressed: () {},
//         //         child: const Text('Trainig')),
//         //     FilledButton(
//         //         style: const ButtonStyle(
//         //           fixedSize: WidgetStatePropertyAll(Size(100, 70)),
//         //           shape: WidgetStatePropertyAll(
//         //               CircleBorder(eccentricity: 0.1)),
//         //           backgroundColor: WidgetStatePropertyAll(Colors.red),
//         //         ),
//         //         onPressed: () {},
//         //         child: const Text('Sleep')),
//         //   ],
//         // )
//       ],
//     );
//   }
// }
