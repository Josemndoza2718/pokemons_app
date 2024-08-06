import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
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
    typePokemons = ApiGetPokemons().getPokemons(widget.index + 1);
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
                    detailsPokemons = ApiGetDetailsPokemons().getDetailsPokemons(snapshot.data?.pokemon?[index].pokemon?.url ?? '');
                    return Card(
                      child: ListTile(
                        leading: FutureBuilder<ModelDetailsPokemons>(
                            future: detailsPokemons,
                            builder: (context, pokeimg) {
                              if (pokeimg.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (pokeimg.hasError) {
                                return Text('Error: ${pokeimg.error}');
                              } else {
                                return Image.network(pokeimg.data!.sprites!.other!.officialArtwork!.frontDefault ?? 'https://media.istockphoto.com/id/1055079680/es/vector/c%C3%A1mara-lineal-negro-como-ninguna-imagen-disponible.jpg?s=612x612&w=0&k=20&c=mYv5-3x668712KVHFnzZX2Tvb_DEQ2Ka7dDwOkTp9Q8=');
                              }
                            }),
                        title: Text(
                            "${snapshot.data!.pokemon![index].pokemon?.name}"),
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
