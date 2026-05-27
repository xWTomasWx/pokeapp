import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';
import '../data/services/pokemon_service.dart';
import 'ability_detail.dart';

class AbilitySearchPage extends StatefulWidget {
  final String selectedLanguageCode;

  const AbilitySearchPage({
    super.key,
    required this.selectedLanguageCode,
  });

  @override
  State<AbilitySearchPage> createState() => _AbilitySearchPageState();
}

class _AbilitySearchPageState extends State<AbilitySearchPage> {
  final PokemonService _pokemonService = PokemonService();
  final TextEditingController _searchController = TextEditingController();
  List<String> _searchResults = [];
  bool _isSearching = false;
  String? _error;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
        _error = null;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _error = null;
    });

    try {
      final results = await _pokemonService.searchAbilities(query, languageCode: widget.selectedLanguageCode);
      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isSearching = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations(widget.selectedLanguageCode);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Habilidades'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar habilidad...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: _performSearch,
            ),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('${localizations.errorPrefix}$_error'),
            )
          else if (_isSearching)
            const Expanded(
              child: Center(child: CircularProgressIndicator()),
            )
          else if (_searchResults.isEmpty && _searchController.text.isNotEmpty)
            Expanded(
              child: Center(
                child: Text('No se encontraron resultados para "${_searchController.text}"'),
              ),
            )
          else if (_searchResults.isNotEmpty)
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(12.0),
                itemCount: _searchResults.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final ability = _searchResults[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12.0),
                      leading: Icon(
                        Icons.flash_on,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        ability,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AbilityDetailPage(
                              abilityName: ability,
                              languageCode: widget.selectedLanguageCode,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            )
          else
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.flash_on,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                    ),
                    const SizedBox(height: 16),
                    const Text('Busca una habilidad para comenzar'),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
