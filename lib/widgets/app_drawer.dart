import 'package:flutter/material.dart';
import '../pages/preferences.dart';
import '../pages/type_effectiveness.dart';

class AppDrawer extends StatelessWidget {
  final String selectedLanguageCode;
  final String selectedLanguageLabel;
  final void Function(String code, String label) onLanguageChanged;

  const AppDrawer({
    super.key,
    required this.selectedLanguageCode,
    required this.selectedLanguageLabel,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
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
                'PokeApp',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.white),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.water_damage),
            title: const Text('Tipos y debilidades'),
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
            title: const Text('Preferencias'),
            subtitle: Text('Idioma actual: $selectedLanguageLabel'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreferencesPage(
                    selectedLanguageCode: selectedLanguageCode,
                    selectedLanguageLabel: selectedLanguageLabel,
                    onLanguageChanged: onLanguageChanged,
                  ),
                ),
              );
            },
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Explora debilidades, resistencias y eficacias de los tipos de Pokémon.',
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
