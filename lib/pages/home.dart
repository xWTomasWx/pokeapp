import 'package:flutter/material.dart';
import '../data/services/pokemon_service.dart';
import '../data/entities/pokemon.dart';
import '../localization/app_localizations.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/app_drawer.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  final String selectedLanguageCode;
  final String selectedLanguageLabel;
  final ThemeMode selectedThemeMode;
  final void Function(String code, String label) onLanguageChanged;
  final void Function(ThemeMode themeMode) onThemeModeChanged;

  const HomePage({
    super.key,
    required this.selectedLanguageCode,
    required this.selectedLanguageLabel,
    required this.selectedThemeMode,
    required this.onLanguageChanged,
    required this.onThemeModeChanged,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokemonService _pokemonService = PokemonService();
  final ScrollController _scrollController = ScrollController();

  List<Pokemon> _pokemonList = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _error;
  int _offset = 0;
  final int _limit = 20;
  bool _isGridView = true;  // Grid view is the default

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _fetchPokemon();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_isLoadingMore && _hasMore && !_isLoading) {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 120) {
        _fetchMorePokemon();
      }
    }
  }

  Future<void> _fetchPokemon() async {
    try {
      final pokemon = await _pokemonService.fetchPokemonList(limit: _limit, offset: _offset);
      setState(() {
        _pokemonList = pokemon;
        _offset += pokemon.length;
        _hasMore = pokemon.length == _limit;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchMorePokemon() async {
    if (_isLoadingMore || !_hasMore || _error != null) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final pokemon = await _pokemonService.fetchPokemonList(limit: _limit, offset: _offset);
      setState(() {
        _pokemonList.addAll(pokemon);
        _offset += pokemon.length;
        _hasMore = pokemon.length == _limit;
        _isLoadingMore = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations(widget.selectedLanguageCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.appTitle),
        actions: [
          Tooltip(
            message: _isGridView ? 'Cambiar a lista' : 'Cambiar a tarjetas',
            child: IconButton(
              icon: Icon(_isGridView ? Icons.view_list : Icons.grid_3x3),
              onPressed: () {
                setState(() {
                  _isGridView = !_isGridView;
                });
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(
        selectedLanguageCode: widget.selectedLanguageCode,
        selectedLanguageLabel: widget.selectedLanguageLabel,
        selectedThemeMode: widget.selectedThemeMode,
        onLanguageChanged: widget.onLanguageChanged,
        onThemeModeChanged: widget.onThemeModeChanged,
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 16),
                  Text(
                    localizations.homeLoadingPokemon,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : _error != null
              ? Center(child: Text('${localizations.errorPrefix}$_error'))
              : _isGridView
                  ? GridView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(12.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: _pokemonList.length + (_hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= _pokemonList.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final pokemon = _pokemonList[index];
                        return PokemonCard(
                          pokemon: pokemon,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  pokemon: pokemon,
                                  languageCode: widget.selectedLanguageCode,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: _pokemonList.length + (_hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= _pokemonList.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 24.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final pokemon = _pokemonList[index];
                        return ListTile(
                          leading: Image.network(
                            pokemon.imageUrl,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.none,
                            width: 50,
                            height: 50,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                          ),
                          title: Text(pokemon.name),
                          subtitle: Text('#${pokemon.id}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailPage(
                                  pokemon: pokemon,
                                  languageCode: widget.selectedLanguageCode,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
    );
  }
}