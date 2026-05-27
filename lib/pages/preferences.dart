import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';
import '../data/services/pokemon_service.dart';

class PreferencesPage extends StatefulWidget {
  final String selectedLanguageCode;
  final String selectedLanguageLabel;
  final ThemeMode selectedThemeMode;
  final void Function(String code, String label) onLanguageChanged;
  final void Function(ThemeMode themeMode) onThemeModeChanged;

  const PreferencesPage({
    super.key,
    required this.selectedLanguageCode,
    required this.selectedLanguageLabel,
    required this.selectedThemeMode,
    required this.onLanguageChanged,
    required this.onThemeModeChanged,
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
  late ThemeMode _selectedThemeMode;

  @override
  void initState() {
    super.initState();
    _selectedLanguageCode = widget.selectedLanguageCode;
    _selectedLanguageLabel = widget.selectedLanguageLabel;
    _selectedThemeMode = widget.selectedThemeMode;
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
    final localizations = AppLocalizations(language.code);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(localizations.languageChangedMessage(language.name)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _selectThemeMode(ThemeMode themeMode) {
    setState(() {
      _selectedThemeMode = themeMode;
    });
    widget.onThemeModeChanged(themeMode);
    final localizations = AppLocalizations(_selectedLanguageCode ?? widget.selectedLanguageCode);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(localizations.themeChangedMessage(themeMode)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations(_selectedLanguageCode ?? widget.selectedLanguageCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.preferencesTitle),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('${localizations.errorPrefix}$_error'))
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
                            '${localizations.preferencesCurrentLanguage}$selectedLabel',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            localizations.preferencesDescription,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            localizations.preferencesThemeTitle,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          RadioListTile<ThemeMode>(
                            value: ThemeMode.light,
                            groupValue: _selectedThemeMode,
                            title: Text(localizations.preferencesLight),
                            subtitle: Text(localizations.preferencesLightSubtitle),
                            onChanged: (value) {
                              if (value != null) _selectThemeMode(value);
                            },
                          ),
                          RadioListTile<ThemeMode>(
                            value: ThemeMode.dark,
                            groupValue: _selectedThemeMode,
                            title: Text(localizations.preferencesDark),
                            subtitle: Text(localizations.preferencesDarkSubtitle),
                            onChanged: (value) {
                              if (value != null) _selectThemeMode(value);
                            },
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
