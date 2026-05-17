import 'package:flutter/material.dart';
import '../data/services/pokemon_service.dart';

class PreferencesPage extends StatefulWidget {
  final String selectedLanguageCode;
  final String selectedLanguageLabel;
  final void Function(String code, String label) onLanguageChanged;

  const PreferencesPage({
    super.key,
    required this.selectedLanguageCode,
    required this.selectedLanguageLabel,
    required this.onLanguageChanged,
  });

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  final PokemonService _pokemonService = PokemonService();
  final List<LanguageOption> _languages = [];
  bool _isLoading = true;
  String? _error;
  String? _selectedLanguageCode;
  String? _selectedLanguageLabel;

  @override
  void initState() {
    super.initState();
    _selectedLanguageCode = widget.selectedLanguageCode;
    _selectedLanguageLabel = widget.selectedLanguageLabel;
    _loadLanguages();
  }

  Future<void> _loadLanguages() async {
    try {
      final languages = await _pokemonService.fetchAvailableLanguages();
      setState(() {
        _languages.clear();
        _languages.addAll(languages);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _selectLanguage(LanguageOption language) {
    setState(() {
      _selectedLanguageCode = language.code;
      _selectedLanguageLabel = language.name;
    });
    widget.onLanguageChanged(language.code, language.name);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Idioma cambiado a ${language.name}'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferencias'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('Error: $_error'))
              : ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _languages.length + 1,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      final selectedLabel = _selectedLanguageLabel ?? _languages
                              .firstWhere(
                                (lang) => lang.code == _selectedLanguageCode,
                                orElse: () => LanguageOption(
                                  code: widget.selectedLanguageCode,
                                  name: widget.selectedLanguageLabel,
                                ),
                              )
                              .name;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Idioma actual: $selectedLabel',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Selecciona el idioma que quieres usar para los datos de la API.',
                          ),
                        ],
                      );
                    }

                    final language = _languages[index - 1];
                    return ListTile(
                      title: Text(language.name),
                      subtitle: Text(language.code),
                      leading: Radio<String>(
                        value: language.code,
                        groupValue: _selectedLanguageCode,
                        onChanged: (value) {
                          if (value != null) {
                            final selectedLang = _languages.firstWhere((lang) => lang.code == value);
                            _selectLanguage(selectedLang);
                          }
                        },
                      ),
                      onTap: () => _selectLanguage(language),
                    );
                  },
                ),
    );
  }
}
