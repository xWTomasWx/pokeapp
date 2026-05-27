import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';
import '../pages/preferences.dart';
import '../pages/type_effectiveness.dart';
import '../pages/pokemon_search.dart';
import '../pages/ability_search.dart';

class AppDrawer extends StatelessWidget {
  final String selectedLanguageCode;
  final String selectedLanguageLabel;
  final ThemeMode selectedThemeMode;
  final void Function(String code, String label) onLanguageChanged;
  final void Function(ThemeMode themeMode) onThemeModeChanged;

  const AppDrawer({
    super.key,
    required this.selectedLanguageCode,
    required this.selectedLanguageLabel,
    required this.selectedThemeMode,
    required this.onLanguageChanged,
    required this.onThemeModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations(selectedLanguageCode);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                localizations.appTitle,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(localizations.drawerHome),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Buscar Pokémon'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PokemonSearchPage(
                    selectedLanguageCode: selectedLanguageCode,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.flash_on),
            title: const Text('Buscar Habilidades'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AbilitySearchPage(
                    selectedLanguageCode: selectedLanguageCode,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.water_damage),
            title: Text(localizations.drawerTypeEffectiveness),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TypeEffectivenessPage(
                    languageCode: selectedLanguageCode,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(localizations.drawerPreferences),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreferencesPage(
                    selectedLanguageCode: selectedLanguageCode,
                    selectedLanguageLabel: selectedLanguageLabel,
                    selectedThemeMode: selectedThemeMode,
                    onLanguageChanged: onLanguageChanged,
                    onThemeModeChanged: onThemeModeChanged,
                  ),
                ),
              );
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              localizations.drawerDescription,
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
