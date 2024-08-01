import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:pokemon_app/models/model_buttons_pokemons.dart';
import 'package:pokemon_app/models/model_pokemons.dart';

String generalApiUrl = 'https://pokeapi.co/api/v2';


//GET TYPE POKEMONS
class ServicesGetTypePokemons {
  Future<ModelButtonsPokemons> getButtonsTypePokemons() async {
    try {
      var buttonServicesApiUrl = Uri.parse("$generalApiUrl/type");
      var response = await http.get(buttonServicesApiUrl);

      if (response.statusCode == 200) {
        log("${response.statusCode}");
        //print("Type Pokemon: ${response.body}");

        var buttonsData = jsonDecode(response.body);
        ModelButtonsPokemons buttonsList = ModelButtonsPokemons.fromJson(buttonsData);

        return buttonsList;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      log("$e");
    }
    throw Exception('Failed to load Type Pokemons');
  }
}

//GET POKEMONS
class ServiceGetPokemons {
  Future<ModelPokemons> getPokemons(int id) async {
   
      var cardServicesApiUrl = Uri.parse('$generalApiUrl/type/$id');
      var response = await http.get(cardServicesApiUrl);

      if (response.statusCode == 200) {
        log("${response.statusCode}");

        final Map<String, dynamic> responseData = jsonDecode(response.body);
        ModelPokemons pokemonsListData = ModelPokemons.fromJson(responseData);
        

        return pokemonsListData;
      } else {
        throw Exception('Failed to load Pokemons');
      }
    
  }
}
