// class ModelByTypePokemons {
//     DamageRelations? damageRelations;
//     List<GameIndex>? gameIndices;
//     Generation? generation;
//     int? id;
//     Generation? moveDamageClass;
//     List<Generation>? moves;
//     String? name;
//     List<Name>? names;
//     List<dynamic>? pastDamageRelations;
//     List<Pokemon>? pokemon;
//     Sprites? sprites;

//     ModelByTypePokemons({
//         this.damageRelations,
//         this.gameIndices,
//         this.generation,
//         this.id,
//         this.moveDamageClass,
//         this.moves,
//         this.name,
//         this.names,
//         this.pastDamageRelations,
//         this.pokemon,
//         this.sprites,
//     });

//     factory ModelByTypePokemons.fromJson(Map<String, dynamic> json) => ModelByTypePokemons(
//         damageRelations: json["damage_relations"] == null ? null : DamageRelations.fromJson(json["damage_relations"]),
//         gameIndices: json["game_indices"] == null ? [] : List<GameIndex>.from(json["game_indices"]!.map((x) => GameIndex.fromJson(x))),
//         generation: json["generation"] == null ? null : Generation.fromJson(json["generation"]),
//         id: json["id"],
//         moveDamageClass: json["move_damage_class"] == null ? null : Generation.fromJson(json["move_damage_class"]),
//         moves: json["moves"] == null ? [] : List<Generation>.from(json["moves"]!.map((x) => Generation.fromJson(x))),
//         name: json["name"],
//         names: json["names"] == null ? [] : List<Name>.from(json["names"]!.map((x) => Name.fromJson(x))),
//         pastDamageRelations: json["past_damage_relations"] == null ? [] : List<dynamic>.from(json["past_damage_relations"]!.map((x) => x)),
//         pokemon: json["pokemon"] == null ? [] : List<Pokemon>.from(json["pokemon"]!.map((x) => Pokemon.fromJson(x))),
//         sprites: json["sprites"] == null ? null : Sprites.fromJson(json["sprites"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "damage_relations": damageRelations?.toJson(),
//         "game_indices": gameIndices == null ? [] : List<dynamic>.from(gameIndices!.map((x) => x.toJson())),
//         "generation": generation?.toJson(),
//         "id": id,
//         "move_damage_class": moveDamageClass?.toJson(),
//         "moves": moves == null ? [] : List<dynamic>.from(moves!.map((x) => x.toJson())),
//         "name": name,
//         "names": names == null ? [] : List<dynamic>.from(names!.map((x) => x.toJson())),
//         "past_damage_relations": pastDamageRelations == null ? [] : List<dynamic>.from(pastDamageRelations!.map((x) => x)),
//         "pokemon": pokemon == null ? [] : List<dynamic>.from(pokemon!.map((x) => x.toJson())),
//         "sprites": sprites?.toJson(),
//     };
// }

// class DamageRelations {
//     List<Generation>? doubleDamageFrom;
//     List<dynamic>? doubleDamageTo;
//     List<dynamic>? halfDamageFrom;
//     List<Generation>? halfDamageTo;
//     List<Generation>? noDamageFrom;
//     List<Generation>? noDamageTo;

//     DamageRelations({
//         this.doubleDamageFrom,
//         this.doubleDamageTo,
//         this.halfDamageFrom,
//         this.halfDamageTo,
//         this.noDamageFrom,
//         this.noDamageTo,
//     });

//     factory DamageRelations.fromJson(Map<String, dynamic> json) => DamageRelations(
//         doubleDamageFrom: json["double_damage_from"] == null ? [] : List<Generation>.from(json["double_damage_from"]!.map((x) => Generation.fromJson(x))),
//         doubleDamageTo: json["double_damage_to"] == null ? [] : List<dynamic>.from(json["double_damage_to"]!.map((x) => x)),
//         halfDamageFrom: json["half_damage_from"] == null ? [] : List<dynamic>.from(json["half_damage_from"]!.map((x) => x)),
//         halfDamageTo: json["half_damage_to"] == null ? [] : List<Generation>.from(json["half_damage_to"]!.map((x) => Generation.fromJson(x))),
//         noDamageFrom: json["no_damage_from"] == null ? [] : List<Generation>.from(json["no_damage_from"]!.map((x) => Generation.fromJson(x))),
//         noDamageTo: json["no_damage_to"] == null ? [] : List<Generation>.from(json["no_damage_to"]!.map((x) => Generation.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "double_damage_from": doubleDamageFrom == null ? [] : List<dynamic>.from(doubleDamageFrom!.map((x) => x.toJson())),
//         "double_damage_to": doubleDamageTo == null ? [] : List<dynamic>.from(doubleDamageTo!.map((x) => x)),
//         "half_damage_from": halfDamageFrom == null ? [] : List<dynamic>.from(halfDamageFrom!.map((x) => x)),
//         "half_damage_to": halfDamageTo == null ? [] : List<dynamic>.from(halfDamageTo!.map((x) => x.toJson())),
//         "no_damage_from": noDamageFrom == null ? [] : List<dynamic>.from(noDamageFrom!.map((x) => x.toJson())),
//         "no_damage_to": noDamageTo == null ? [] : List<dynamic>.from(noDamageTo!.map((x) => x.toJson())),
//     };
// }

// class Generation {
//     String? name;
//     String? url;

//     Generation({
//         this.name,
//         this.url,
//     });

//     factory Generation.fromJson(Map<String, dynamic> json) => Generation(
//         name: json["name"],
//         url: json["url"],
//     );

//     Map<String, dynamic> toJson() => {
//         "name": name,
//         "url": url,
//     };
// }

// class GameIndex {
//     int? gameIndex;
//     Generation? generation;

//     GameIndex({
//         this.gameIndex,
//         this.generation,
//     });

//     factory GameIndex.fromJson(Map<String, dynamic> json) => GameIndex(
//         gameIndex: json["game_index"],
//         generation: json["generation"] == null ? null : Generation.fromJson(json["generation"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "game_index": gameIndex,
//         "generation": generation?.toJson(),
//     };
// }

// class Name {
//     Generation? language;
//     String? name;

//     Name({
//         this.language,
//         this.name,
//     });

//     factory Name.fromJson(Map<String, dynamic> json) => Name(
//         language: json["language"] == null ? null : Generation.fromJson(json["language"]),
//         name: json["name"],
//     );

//     Map<String, dynamic> toJson() => {
//         "language": language?.toJson(),
//         "name": name,
//     };
// }

// class Pokemon {
//     Generation? pokemon;
//     int? slot;

//     Pokemon({
//         this.pokemon,
//         this.slot,
//     });

//     factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
//         pokemon: json["pokemon"] == null ? null : Generation.fromJson(json["pokemon"]),
//         slot: json["slot"],
//     );

//     Map<String, dynamic> toJson() => {
//         "pokemon": pokemon?.toJson(),
//         "slot": slot,
//     };
// }

// class Sprites {
//     String? backDefault;
//     dynamic backFemale;
//     String? backShiny;
//     dynamic backShinyFemale;
//     String? frontDefault;
//     dynamic frontFemale;
//     String? frontShiny;
//     dynamic frontShinyFemale;
    
//     Sprites? animated;

//     Sprites({
//         this.backDefault,
//         this.backFemale,
//         this.backShiny,
//         this.backShinyFemale,
//         this.frontDefault,
//         this.frontFemale,
//         this.frontShiny,
//         this.frontShinyFemale,
//         this.animated,
//     });

//     factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
//         backDefault: json["back_default"],
//         backFemale: json["back_female"],
//         backShiny: json["back_shiny"],
//         backShinyFemale: json["back_shiny_female"],
//         frontDefault: json["front_default"],
//         frontFemale: json["front_female"],
//         frontShiny: json["front_shiny"],
//         frontShinyFemale: json["front_shiny_female"],
//         animated: json["animated"] == null ? null : Sprites.fromJson(json["animated"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "back_default": backDefault,
//         "back_female": backFemale,
//         "back_shiny": backShiny,
//         "back_shiny_female": backShinyFemale,
//         "front_default": frontDefault,
//         "front_female": frontFemale,
//         "front_shiny": frontShiny,
//         "front_shiny_female": frontShinyFemale,
//         "animated": animated?.toJson(),
//     };
// }
