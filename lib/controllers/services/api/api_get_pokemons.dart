import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:pokemon_app/models/model_by_type_pokemons.dart';
import 'package:pokemon_app/models/model_details_pokemons.dart';
import 'package:pokemon_app/models/model_type_pokemons.dart';

String generalApiUrl = 'https://pokeapi.co/api/v2';

//GET TYPE POKEMONS
class ApiGetTypePokemons {
  Future<ModelTypePokemons> getButtonsTypePokemons() async {
    try {
      var buttonServicesApiUrl = Uri.parse("$generalApiUrl/type");
      var response = await http.get(buttonServicesApiUrl);

      if (response.statusCode == 200) {
        log("${response.statusCode}");
        //print("Type Pokemon: ${response.body}");

        var buttonsData = jsonDecode(response.body);
        ModelTypePokemons buttonsList = ModelTypePokemons.fromJson(buttonsData);

        return buttonsList;
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else if (response.statusCode == 422) {
        return throw Exception("Unprocessable Entity");
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      log("$e");
    }
    throw Exception('Failed to load Type Pokemons');
  }
}

//GET POKEMONS BY TYPES
class ApiGetPokemons {
  Future<ModelByTypePokemons> getPokemons(int id) async {

      var cardServicesApiUrl = Uri.parse('$generalApiUrl/type/$id');
      var response = await http.get(cardServicesApiUrl);

      if (response.statusCode == 200) {
        log("${response.statusCode}");

        final Map<String, dynamic> responseData = jsonDecode(response.body);
        ModelByTypePokemons pokemonsListData = ModelByTypePokemons.fromJson(responseData);

        return pokemonsListData;
      } else {
        throw Exception('Failed to load Pokemons');
      }

  }
}

class ApiGetDetailsPokemons {
  Future<ModelDetailsPokemons> getDetailsPokemons(String url) async {
    try {
      var cardServicesApiUrl = Uri.parse(url);
      var response = await http.get(cardServicesApiUrl);

      if (response.statusCode == 200) {
        log("${response.statusCode}");

        final Map<String, dynamic> responseData = jsonDecode(response.body);
        ModelDetailsPokemons pokemonsDetailstData = ModelDetailsPokemons.fromJson(responseData);

        return pokemonsDetailstData;

      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized');
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else if (response.statusCode == 422) {
        return throw Exception("Unprocessable Entity");
      } else {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      log("$e");
    }

    throw Exception('Failed to load Pokemons');
  }
}


// class ApiGetDetailsPokemons {
//   Future<ModelDetailsPokemons> getDetailsPokemons(int id) async {
//     try {
//       var cardServicesApiUrl = Uri.parse('$generalApiUrl/pokemon/$id');
//       var response = await http.get(cardServicesApiUrl);

//       if (response.statusCode == 200) {
//         log("${response.statusCode}");

//         final Map<String, dynamic> responseData = jsonDecode(response.body);
//         ModelDetailsPokemons pokemonsDetailstData = ModelDetailsPokemons.fromJson(responseData);

//         return pokemonsDetailstData;

//       } else if (response.statusCode == 401) {
//         throw Exception('Unauthorized');
//       } else if (response.statusCode == 500) {
//         throw Exception("Server Error");
//       } else if (response.statusCode == 422) {
//         return throw Exception("Unprocessable Entity");
//       } else {
//         throw Exception("Something went wrong");
//       }
//     } catch (e) {
//       log("$e");
//     }

//     throw Exception('Failed to load Pokemons');
//   }
// }

