import 'dart:convert';
import 'package:http/http.dart' as http;
import '../entities/pokemon.dart';

class LanguageOption {
  final String code;
  final String name;

  const LanguageOption({required this.code, required this.name});
}

class PokemonService {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<Pokemon>> fetchPokemonList({int limit = 20, int offset = 0}) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon?limit=$limit&offset=$offset'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;
      return results.map((json) => Pokemon.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }

  Future<Pokemon> fetchPokemonDetail(int id, {String languageCode = 'es'}) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final speciesUrl = (data['species']?['url'] as String?) ?? '$baseUrl/pokemon-species/$id';
      final speciesJson = await _fetchJson(speciesUrl);
      final localizedName = _extractLocalizedName(speciesJson['names'] as List<dynamic>?, languageCode);
      final flavorText = _extractLocalizedFlavorText(speciesJson['flavor_text_entries'] as List<dynamic>?, languageCode);

      final types = await Future.wait((data['types'] as List<dynamic>? ?? []).map<Future<String>>((item) async {
        final url = item['type']?['url'] as String?;
        final fallback = item['type']?['name'] as String? ?? '';
        return await _fetchLocalizedResourceName(url, fallback, languageCode);
      }));

      final abilities = await Future.wait((data['abilities'] as List<dynamic>? ?? []).map<Future<String>>((item) async {
        final url = item['ability']?['url'] as String?;
        final fallback = item['ability']?['name'] as String? ?? '';
        return await _fetchLocalizedResourceName(url, fallback, languageCode);
      }));

      final stats = (data['stats'] as List<dynamic>?)?.fold<Map<String, int>>(
            <String, int>{},
            (acc, item) {
              final key = item['stat']['name'] as String;
              acc[_translateStatKey(key)] = item['base_stat'] as int;
              return acc;
            },
          ) ??
          <String, int>{};

      final pokemonId = data['id'] as int;
      final name = data['name'] as String;
      final url = (data['species']?['url'] as String?) ?? '';

      return Pokemon(
        id: pokemonId,
        name: name,
        url: url,
        imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png',
        height: data['height'] as int?,
        weight: data['weight'] as int?,
        baseExperience: data['base_experience'] as int?,
        types: types,
        abilities: abilities,
        stats: stats,
        localizedName: localizedName.isNotEmpty ? localizedName : null,
        flavorText: flavorText,
      );
    } else {
      throw Exception('Failed to load Pokemon detail');
    }
  }

  Future<Map<String, dynamic>> _fetchJson(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    throw Exception('Failed to load data from $url');
  }

  Future<List<LanguageOption>> fetchAvailableLanguages() async {
    final response = await http.get(Uri.parse('$baseUrl/language'));
    if (response.statusCode != 200) {
      throw Exception('Failed to load available languages');
    }

    final data = json.decode(response.body);
    final results = (data['results'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];

    final languages = await Future.wait<LanguageOption?>(
      results.map((entry) async {
        final url = entry['url'] as String?;
        if (url == null) return null;
        final detail = await _fetchJson(url);
        if (detail['official'] != true) return null;
        final code = detail['iso639'] as String? ?? detail['name'] as String? ?? '';
        final label = _extractLocalizedName(detail['names'] as List<dynamic>?, 'en');
        if (code.isEmpty || label.isEmpty) return null;
        return LanguageOption(code: code, name: label);
      }),
    );

    return languages.whereType<LanguageOption>().toList()..sort((a, b) => a.name.compareTo(b.name));
  }

  String _extractLocalizedName(List<dynamic>? names, String languageCode) {
    if (names == null) return '';

    for (final item in names.cast<Map<String, dynamic>>()) {
      if (item['language']?['name'] == languageCode) {
        return item['name'] as String? ?? '';
      }
    }

    for (final item in names.cast<Map<String, dynamic>>()) {
      if (item['language']?['name'] == 'en') {
        return item['name'] as String? ?? '';
      }
    }

    return '';
  }

  String? _extractLocalizedFlavorText(List<dynamic>? entries, String languageCode) {
    if (entries == null) return null;

    for (final item in entries.cast<Map<String, dynamic>>()) {
      if (item['language']?['name'] == languageCode) {
        final flavor = item['flavor_text'] as String?;
        if (flavor != null && flavor.isNotEmpty) {
          return flavor.replaceAll(RegExp(r'\n|\f'), ' ').trim();
        }
      }
    }

    for (final item in entries.cast<Map<String, dynamic>>()) {
      if (item['language']?['name'] == 'en') {
        final flavor = item['flavor_text'] as String?;
        if (flavor != null && flavor.isNotEmpty) {
          return flavor.replaceAll(RegExp(r'\n|\f'), ' ').trim();
        }
      }
    }

    return null;
  }

  Future<String> _fetchLocalizedResourceName(String? url, String fallback, String languageCode) async {
    if (url == null || url.isEmpty) return fallback;
    try {
      final data = await _fetchJson(url);
      final name = _extractLocalizedName(data['names'] as List<dynamic>?, languageCode);
      return name.isNotEmpty ? name : fallback;
    } catch (_) {
      return fallback;
    }
  }

  String _translateStatKey(String key) {
    switch (key) {
      case 'hp':
        return 'PS';
      case 'attack':
        return 'Ataque';
      case 'defense':
        return 'Defensa';
      case 'special-attack':
        return 'Ataque especial';
      case 'special-defense':
        return 'Defensa especial';
      case 'speed':
        return 'Velocidad';
      default:
        return key;
    }
  }

  Future<Map<String, Map<String, double>>> fetchTypeEffectivenessChart({String languageCode = 'es'}) async {
    final typeIndex = await _fetchJson('$baseUrl/type');
    final typeEntries = (typeIndex['results'] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? [];

    final typeDetails = await Future.wait<Map<String, dynamic>>(
      typeEntries.map((entry) => _fetchJson(entry['url'] as String)),
    );

    final englishToLocalized = <String, String>{};
    for (final detail in typeDetails) {
      final englishName = detail['name'] as String;
      final localizedName = _extractLocalizedName(detail['names'] as List<dynamic>?, languageCode);
      englishToLocalized[englishName] = localizedName.isNotEmpty ? localizedName : _capitalize(englishName);
    }

    final chart = <String, Map<String, double>>{};
    for (final detail in typeDetails) {
      final englishName = detail['name'] as String;
      final displayName = englishToLocalized[englishName]!;
      final damageRelations = detail['damage_relations'] as Map<String, dynamic>;
      final effects = <String, double>{};

      _addDamageRelations(effects, damageRelations['double_damage_to'] as List<dynamic>?, 2.0, englishToLocalized);
      _addDamageRelations(effects, damageRelations['half_damage_to'] as List<dynamic>?, 0.5, englishToLocalized);
      _addDamageRelations(effects, damageRelations['no_damage_to'] as List<dynamic>?, 0.0, englishToLocalized);

      chart[displayName] = effects;
    }

    return chart;
  }

  void _addDamageRelations(
    Map<String, double> effects,
    List<dynamic>? entries,
    double multiplier,
    Map<String, String> englishToLocalized,
  ) {
    if (entries == null) return;
    for (final item in entries.cast<Map<String, dynamic>>()) {
      final targetName = item['name'] as String;
      final displayName = englishToLocalized[targetName] ?? _capitalize(targetName);
      effects[displayName] = multiplier;
    }
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }
}
