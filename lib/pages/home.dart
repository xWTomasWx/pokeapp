import 'package:flutter/material.dart';
import '../data/services/pokemon_service.dart';
import '../data/entities/pokemon.dart';
import '../widgets/app_drawer.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  final String selectedLanguageCode;
  final String selectedLanguageLabel;
  final void Function(String code, String label) onLanguageChanged;

  const HomePage({
    super.key,
    required this.selectedLanguageCode,
    required this.selectedLanguageLabel,
    required this.onLanguageChanged,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeApp'),
      ),
      drawer: AppDrawer(
        selectedLanguageCode: widget.selectedLanguageCode,
        selectedLanguageLabel: widget.selectedLanguageLabel,
        onLanguageChanged: widget.onLanguageChanged,
      ),
      body: _isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Cargando Pokémon...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : _error != null
              ? Center(child: Text('Error: $_error'))
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