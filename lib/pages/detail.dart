import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';
import '../data/entities/pokemon.dart';
import '../data/services/pokemon_service.dart';
import 'ability_detail.dart';

class DetailPage extends StatefulWidget {
  final Pokemon pokemon;
  final String languageCode;

  const DetailPage({
    super.key,
    required this.pokemon,
    required this.languageCode,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final PokemonService _pokemonService = PokemonService();
  Pokemon? _pokemonDetail;
  bool _isLoading = true;
  String? _error;
  bool _isShiny = false;

  @override
  void initState() {
    super.initState();
    _loadPokemonDetail();
  }

  Future<void> _loadPokemonDetail() async {
    try {
      final detail = await _pokemonService.fetchPokemonDetail(
        widget.pokemon.id,
        languageCode: widget.languageCode,
      );
      setState(() {
        _pokemonDetail = detail;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  String _getImageUrl() {
    final pokemon = _pokemonDetail ?? widget.pokemon;
    final baseUrl = 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown';
    return _isShiny ? '$baseUrl/shiny/${pokemon.id}.gif' : '$baseUrl/${pokemon.id}.gif';
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildChips(String title, List<String>? values) {
    if (values == null || values.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: values.map((value) => Chip(label: Text(value))).toList(),
        ),
      ],
    );
  }

  Widget _buildAbilityChips(String title, List<String>? values) {
    if (values == null || values.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: values
              .map(
                (ability) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AbilityDetailPage(
                          abilityName: ability,
                          languageCode: widget.languageCode,
                        ),
                      ),
                    );
                  },
                  child: Chip(
                    label: Text(ability),
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = _pokemonDetail ?? widget.pokemon;

    final localizations = AppLocalizations(widget.languageCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.displayName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Selector de versión (Normal/Shiny)
            Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: ToggleButtons(
                  isSelected: [!_isShiny, _isShiny],
                  onPressed: (index) {
                    setState(() {
                      _isShiny = index == 1;
                    });
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(localizations.detailNormal),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(localizations.detailShiny),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Image.network(
                _getImageUrl(),
                fit: BoxFit.contain,
                filterQuality: FilterQuality.none,
                width: 300,
                height: 300,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 300),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                pokemon.displayName,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 8),
            Center(child: Text('#${pokemon.id}')),
            const SizedBox(height: 24),
            if (_isLoading) ...[
              const Center(child: CircularProgressIndicator()),
              const SizedBox(height: 24),
            ] else if (_error != null) ...[
              Center(child: Text('${localizations.errorPrefix}$_error')),
              const SizedBox(height: 24),
            ] else ...[
              if (pokemon.flavorText != null) ...[
                Text(localizations.detailDescription, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(pokemon.flavorText!),
                const SizedBox(height: 16),
              ],
              _buildInfoRow(localizations.detailHeight, '${pokemon.height ?? '-'}'),
              _buildInfoRow(localizations.detailWeight, '${pokemon.weight ?? '-'}'),
              _buildInfoRow(localizations.detailBaseExp, '${pokemon.baseExperience ?? '-'}'),
              const SizedBox(height: 16),
              _buildChips(localizations.detailTypes, pokemon.types),
              const SizedBox(height: 16),
              _buildAbilityChips(localizations.detailAbilities, pokemon.abilities),
              const SizedBox(height: 16),
              if (pokemon.stats != null && pokemon.stats!.isNotEmpty) ...[
                Text(localizations.detailStats, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                ...pokemon.stats!.entries
                    .map((entry) => _buildInfoRow(entry.key, entry.value.toString())),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
