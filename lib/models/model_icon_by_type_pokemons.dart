class ModelIconByTypePokemons {
  final String iconPokemons;
  final String labelIconPokemons;

  const ModelIconByTypePokemons({
    required this.iconPokemons,
    required this.labelIconPokemons,
  });
}

// Generar la lista de iconos por tipo de Pokémon
List<ModelIconByTypePokemons> generateIconByTypePokemons() {
  const types = [
    'normal',
    'lucha',
    'volador',
    'veneno',
    'tierra',
    'roca',
    'bicho',
    'fantasma',
    'acero',
    'fuego',
    'agua',
    'planta',
    'eléctrico',
    'psíquico',
    'hielo',
    'dragón',
    'siniestro',
    'hada'
  ];

  // Ruta base
  const String iconPath = 'assets/icon_type_pokemons/Tipo_';
  const String labelPath = 'assets/icon_labels_pokemons/80px-Tipo_';

  List<ModelIconByTypePokemons> icons = types.map((type) {
    return ModelIconByTypePokemons(
      iconPokemons: '${iconPath}${type}_icono_EP.svg',
      labelIconPokemons: '${labelPath}${type}_EP.png',
    );
  }).toList();

  // Agregar iconos "image_not_found" al final de la lista
  icons.addAll([
    const ModelIconByTypePokemons(
      iconPokemons: 'assets/image_not_found.svg',
      labelIconPokemons: 'assets/image_not_found.svg',
    ),
    const ModelIconByTypePokemons(
      iconPokemons: 'assets/image_not_found.svg',
      labelIconPokemons: 'assets/image_not_found.svg',
    ),
  ]);

  return icons;
}

// Llamar a la función para obtener la lista de iconos
List<ModelIconByTypePokemons> iconByTypePokemons = generateIconByTypePokemons();
