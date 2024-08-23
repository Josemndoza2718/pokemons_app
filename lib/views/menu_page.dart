// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_app/controllers/services/api/api_get_pokemons.dart';
import 'package:pokemon_app/models/model_icon_by_type_pokemons.dart';
import 'package:pokemon_app/models/model_type_pokemons.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late Future<ModelTypePokemons> buttonsTypePokemons;
  final OverlayPortalController _tooltipController = OverlayPortalController();

  @override
  void initState() {
    super.initState();
    buttonsTypePokemons = ApiGetTypePokemons().getButtonsTypePokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffc5232c),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
        ),
        toolbarHeight: 60,
        leading: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Image.asset("assets/png/icon_pokeball.png"),
        ),
        title: const Text("Pokemons", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
         
          // ElevatedButton(
          //   onPressed: _tooltipController.toggle,
          //   child: OverlayPortal(
          //     controller: _tooltipController,
          //     overlayChildBuilder: (BuildContext context) {
          //       return const Align(
          //         alignment: Alignment.topCenter,
          //         child: ColoredBox(
          //           color: Colors.amberAccent,
          //           child: Text('tooltip'),
          //         ),
          //       );
          //     },
          //     child: const Text('Press to show/hide tooltip'),
          //   ),
          // ),
          const SizedBox(height: 30),
          Center(
            child: Container(
              height: 200,
              width: 350,
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
          ),
        ],
      ),
    );
  }
}
