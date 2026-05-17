class Pokemon {
  final int id;
  final String name;
  final String url;
  final String imageUrl;
  final int? height;
  final int? weight;
  final int? baseExperience;
  final List<String>? types;
  final List<String>? abilities;
  final Map<String, int>? stats;
  final String? localizedName;
  final String? flavorText;

  Pokemon({
    required this.id,
    required this.name,
    required this.url,
    required this.imageUrl,
    this.height,
    this.weight,
    this.baseExperience,
    this.types,
    this.abilities,
    this.stats,
    this.localizedName,
    this.flavorText,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String;
    final id = int.parse(url.split('/')[6]); // Extract ID from URL
    return Pokemon(
      id: id,
      name: json['name'],
      url: url,
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
    );
  }

  String get displayName => localizedName ?? name;

  factory Pokemon.fromDetailJson(Map<String, dynamic> json,
      {String? localizedName, String? flavorText}) {
    final id = json['id'] as int;
    final name = json['name'] as String;
    final url = (json['species']?['url'] as String?) ?? '';
    final types = (json['types'] as List<dynamic>?)
        ?.map((item) => item['type']['name'] as String)
        .toList();
    final abilities = (json['abilities'] as List<dynamic>?)
        ?.map((item) => item['ability']['name'] as String)
        .toList();
    final stats = (json['stats'] as List<dynamic>?)?.fold<Map<String, int>>(
      <String, int>{},
      (acc, item) {
        acc[item['stat']['name'] as String] = item['base_stat'] as int;
        return acc;
      },
    );

    return Pokemon(
      id: id,
      name: name,
      url: url,
      imageUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
      height: json['height'] as int?,
      weight: json['weight'] as int?,
      baseExperience: json['base_experience'] as int?,
      types: types,
      abilities: abilities,
      stats: stats,
      localizedName: localizedName,
      flavorText: flavorText,
    );
  }
}
