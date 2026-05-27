import 'package:flutter/material.dart';

class AppLocalizations {
  final String languageCode;

  AppLocalizations(this.languageCode);

  static const Map<String, Map<String, String>> _strings = {
    'en': {
      'appTitle': 'PokeApp',
      'homeLoadingPokemon': 'Loading Pokémon...',
      'drawerHome': 'Home',
      'drawerTypeEffectiveness': 'Type weaknesses',
      'drawerPreferences': 'Preferences',
      'drawerDescription': 'Explore weaknesses, resistances and type effectiveness.',
      'preferencesTitle': 'Preferences',
      'preferencesCurrentLanguage': 'Current language: ',
      'preferencesDescription': 'Select the language for API data.',
      'preferencesThemeTitle': 'App theme',
      'preferencesLight': 'Light',
      'preferencesLightSubtitle': 'Use light colors',
      'preferencesDark': 'Dark',
      'preferencesDarkSubtitle': 'Use dark colors',
      'preferencesSelectLanguage': 'Select the language you want to use for API data.',
      'languageChanged': 'Language changed to ',
      'themeChangedLight': 'Light mode activated',
      'themeChangedDark': 'Dark mode activated',
      'errorPrefix': 'Error: ',
      'detailNormal': 'Normal',
      'detailShiny': 'Shiny',
      'detailDescription': 'Description',
      'detailHeight': 'Height',
      'detailWeight': 'Weight',
      'detailBaseExp': 'Base exp',
      'detailTypes': 'Types',
      'detailAbilities': 'Abilities',
      'detailStats': 'Stats',
      'typeEffectivenessTitle': 'Type weaknesses and effectiveness',
      'typeEffectivenessLimit': 'You can only select up to 2 types.',
      'typeEffectivenessSelectOneOrTwo': 'Select 1 or 2 types to see weaknesses and effectiveness.',
      'typeEffectivenessSelectedTypes': 'Selected types: ',
      'typeEffectivenessSelectTypes': 'Select up to two types:',
      'typeEffectivenessResults': 'Results',
      'typeEffectivenessNoSelection': 'You have not selected any type yet.',
      'typeEffectivenessWeaknesses': 'Weaknesses:',
      'typeEffectivenessNeutral': 'Neutral effectiveness:',
      'typeEffectivenessResistances': 'Resistances:',
      'typeEffectivenessTip': 'Tip: if you select two types, the result combines both defenses by multiplying effectiveness.',
    },
    'es': {
      'appTitle': 'PokeApp',
      'homeLoadingPokemon': 'Cargando Pokémon...',
      'drawerHome': 'Inicio',
      'drawerTypeEffectiveness': 'Tipos y debilidades',
      'drawerPreferences': 'Preferencias',
      'drawerDescription': 'Explora debilidades, resistencias y eficacias de los tipos de Pokémon.',
      'preferencesTitle': 'Preferencias',
      'preferencesCurrentLanguage': 'Idioma actual: ',
      'preferencesDescription': 'Selecciona el idioma que quieres usar para los datos de la API.',
      'preferencesThemeTitle': 'Tema de la aplicación',
      'preferencesLight': 'Claro',
      'preferencesLightSubtitle': 'Usar colores claros',
      'preferencesDark': 'Oscuro',
      'preferencesDarkSubtitle': 'Usar colores oscuros',
      'preferencesSelectLanguage': 'Selecciona el idioma que quieres usar para los datos de la API.',
      'languageChanged': 'Idioma cambiado a ',
      'themeChangedLight': 'Modo claro activado',
      'themeChangedDark': 'Modo oscuro activado',
      'errorPrefix': 'Error: ',
      'detailNormal': 'Normal',
      'detailShiny': 'Shiny',
      'detailDescription': 'Descripción',
      'detailHeight': 'Altura',
      'detailWeight': 'Peso',
      'detailBaseExp': 'Exp. Base',
      'detailTypes': 'Tipos',
      'detailAbilities': 'Habilidades',
      'detailStats': 'Estadísticas',
      'typeEffectivenessTitle': 'Debilidades y Eficacias de Tipos',
      'typeEffectivenessLimit': 'Solo puedes seleccionar hasta 2 tipos.',
      'typeEffectivenessSelectOneOrTwo': 'Selecciona 1 o 2 tipos para ver debilidades y efectividades.',
      'typeEffectivenessSelectedTypes': 'Tipos seleccionados: ',
      'typeEffectivenessSelectTypes': 'Selecciona hasta dos tipos:',
      'typeEffectivenessResults': 'Resultados',
      'typeEffectivenessNoSelection': 'Aún no has seleccionado ningún tipo.',
      'typeEffectivenessWeaknesses': 'Debilidades:',
      'typeEffectivenessNeutral': 'Eficacias neutrales:',
      'typeEffectivenessResistances': 'Resistencias:',
      'typeEffectivenessTip': 'Consejo: si seleccionas dos tipos, el resultado combina ambas defensas multiplicando la eficacia.',
    },
    'fr': {
      'appTitle': 'PokeApp',
      'homeLoadingPokemon': 'Chargement des Pokémon...',
      'drawerHome': 'Accueil',
      'drawerTypeEffectiveness': 'Types et faiblesses',
      'drawerPreferences': 'Préférences',
      'drawerDescription': 'Explorez les faiblesses, résistances et efficacités de type.',
      'preferencesTitle': 'Préférences',
      'preferencesCurrentLanguage': 'Langue actuelle : ',
      'preferencesDescription': 'Sélectionnez la langue pour les données de l’API.',
      'preferencesThemeTitle': 'Thème de l’application',
      'preferencesLight': 'Clair',
      'preferencesLightSubtitle': 'Utiliser des couleurs claires',
      'preferencesDark': 'Sombre',
      'preferencesDarkSubtitle': 'Utiliser des couleurs sombres',
      'preferencesSelectLanguage': 'Sélectionnez la langue que vous souhaitez utiliser pour les données de l’API.',
      'languageChanged': 'Langue changée en ',
      'themeChangedLight': 'Mode clair activé',
      'themeChangedDark': 'Mode sombre activé',
      'errorPrefix': 'Erreur : ',
      'detailNormal': 'Normal',
      'detailShiny': 'Shiny',
      'detailDescription': 'Description',
      'detailHeight': 'Taille',
      'detailWeight': 'Poids',
      'detailBaseExp': 'Exp. de base',
      'detailTypes': 'Types',
      'detailAbilities': 'Capacités',
      'detailStats': 'Statistiques',
      'typeEffectivenessTitle': 'Faiblesses et efficacités de types',
      'typeEffectivenessLimit': 'Vous pouvez sélectionner au maximum 2 types.',
      'typeEffectivenessSelectOneOrTwo': 'Sélectionnez 1 ou 2 types pour voir les faiblesses et les efficacités.',
      'typeEffectivenessSelectedTypes': 'Types sélectionnés : ',
      'typeEffectivenessSelectTypes': 'Sélectionnez jusqu’à deux types :',
      'typeEffectivenessResults': 'Résultats',
      'typeEffectivenessNoSelection': 'Vous n’avez sélectionné aucun type pour le moment.',
      'typeEffectivenessWeaknesses': 'Faiblesses :',
      'typeEffectivenessNeutral': 'Efficacités neutres :',
      'typeEffectivenessResistances': 'Résistances :',
      'typeEffectivenessTip': 'Astuce : si vous sélectionnez deux types, le résultat combine les deux défenses en multipliant l’efficacité.',
    },
    'de': {
      'appTitle': 'PokeApp',
      'homeLoadingPokemon': 'Pokémon werden geladen...',
      'drawerHome': 'Startseite',
      'drawerTypeEffectiveness': 'Typen und Schwächen',
      'drawerPreferences': 'Einstellungen',
      'drawerDescription': 'Entdecke Schwächen, Resistenzen und Typeneffizienz.',
      'preferencesTitle': 'Einstellungen',
      'preferencesCurrentLanguage': 'Aktuelle Sprache: ',
      'preferencesDescription': 'Wählen Sie die Sprache für die API-Daten.',
      'preferencesThemeTitle': 'App-Thema',
      'preferencesLight': 'Hell',
      'preferencesLightSubtitle': 'Helle Farben verwenden',
      'preferencesDark': 'Dunkel',
      'preferencesDarkSubtitle': 'Dunkle Farben verwenden',
      'preferencesSelectLanguage': 'Wählen Sie die Sprache, die Sie für die API-Daten verwenden möchten.',
      'languageChanged': 'Sprache geändert auf ',
      'themeChangedLight': 'Hellmodus aktiviert',
      'themeChangedDark': 'Dunkelmodus aktiviert',
      'errorPrefix': 'Fehler: ',
      'detailNormal': 'Normal',
      'detailShiny': 'Shiny',
      'detailDescription': 'Beschreibung',
      'detailHeight': 'Größe',
      'detailWeight': 'Gewicht',
      'detailBaseExp': 'Basis-EP',
      'detailTypes': 'Typen',
      'detailAbilities': 'Fähigkeiten',
      'detailStats': 'Werte',
      'typeEffectivenessTitle': 'Schwächen und Effektivität der Typen',
      'typeEffectivenessLimit': 'Sie können maximal 2 Typen auswählen.',
      'typeEffectivenessSelectOneOrTwo': 'Wählen Sie 1 oder 2 Typen aus, um Schwächen und Effektivität zu sehen.',
      'typeEffectivenessSelectedTypes': 'Ausgewählte Typen: ',
      'typeEffectivenessSelectTypes': 'Wählen Sie bis zu zwei Typen aus:',
      'typeEffectivenessResults': 'Ergebnisse',
      'typeEffectivenessNoSelection': 'Sie haben noch keinen Typ ausgewählt.',
      'typeEffectivenessWeaknesses': 'Schwächen:',
      'typeEffectivenessNeutral': 'Neutrale Effektivität:',
      'typeEffectivenessResistances': 'Resistenzen:',
      'typeEffectivenessTip': 'Tipp: Wenn Sie zwei Typen auswählen, werden beide Verteidigungen durch Multiplikation der Effektivität kombiniert.',
    },
    'it': {
      'appTitle': 'PokeApp',
      'homeLoadingPokemon': 'Caricamento Pokémon...',
      'drawerHome': 'Home',
      'drawerTypeEffectiveness': 'Tipi e debolezze',
      'drawerPreferences': 'Preferenze',
      'drawerDescription': 'Esplora debolezze, resistenze ed efficacia dei tipi.',
      'preferencesTitle': 'Preferenze',
      'preferencesCurrentLanguage': 'Lingua attuale: ',
      'preferencesDescription': 'Seleziona la lingua da usare per i dati API.',
      'preferencesThemeTitle': 'Tema dell’app',
      'preferencesLight': 'Chiaro',
      'preferencesLightSubtitle': 'Usa colori chiari',
      'preferencesDark': 'Scuro',
      'preferencesDarkSubtitle': 'Usa colori scuri',
      'preferencesSelectLanguage': 'Seleziona la lingua che vuoi usare per i dati dell’API.',
      'languageChanged': 'Lingua cambiata in ',
      'themeChangedLight': 'Modalità chiara attivata',
      'themeChangedDark': 'Modalità scura attivata',
      'errorPrefix': 'Errore: ',
      'detailNormal': 'Normale',
      'detailShiny': 'Shiny',
      'detailDescription': 'Descrizione',
      'detailHeight': 'Altezza',
      'detailWeight': 'Peso',
      'detailBaseExp': 'Exp. base',
      'detailTypes': 'Tipi',
      'detailAbilities': 'Abilità',
      'detailStats': 'Statistiche',
      'typeEffectivenessTitle': 'Debolezze ed efficacia dei tipi',
      'typeEffectivenessLimit': 'Puoi selezionare al massimo 2 tipi.',
      'typeEffectivenessSelectOneOrTwo': 'Seleziona 1 o 2 tipi per vedere debolezze ed efficacia.',
      'typeEffectivenessSelectedTypes': 'Tipi selezionati: ',
      'typeEffectivenessSelectTypes': 'Seleziona fino a due tipi:',
      'typeEffectivenessResults': 'Risultati',
      'typeEffectivenessNoSelection': 'Non hai ancora selezionato nessun tipo.',
      'typeEffectivenessWeaknesses': 'Debolezze:',
      'typeEffectivenessNeutral': 'Efficacia neutra:',
      'typeEffectivenessResistances': 'Resistenze:',
      'typeEffectivenessTip': 'Suggerimento: se selezioni due tipi, il risultato combina entrambe le difese moltiplicando l’efficacia.',
    },
    'ja': {
      'appTitle': 'ポケアプリ',
      'homeLoadingPokemon': 'ポケモンを読み込み中...',
      'drawerHome': 'ホーム',
      'drawerTypeEffectiveness': 'タイプと弱点',
      'drawerPreferences': '設定',
      'drawerDescription': '弱点、耐性、タイプ相性を確認しましょう。',
      'preferencesTitle': '設定',
      'preferencesCurrentLanguage': '現在の言語: ',
      'preferencesDescription': 'APIデータに使用する言語を選択してください。',
      'preferencesThemeTitle': 'アプリのテーマ',
      'preferencesLight': 'ライト',
      'preferencesLightSubtitle': '明るい配色を使用する',
      'preferencesDark': 'ダーク',
      'preferencesDarkSubtitle': '暗い配色を使用する',
      'preferencesSelectLanguage': 'APIデータに使用する言語を選択してください。',
      'languageChanged': '言語を変更しました: ',
      'themeChangedLight': 'ライトモードが有効になりました',
      'themeChangedDark': 'ダークモードが有効になりました',
      'errorPrefix': 'エラー: ',
      'detailNormal': 'ノーマル',
      'detailShiny': '色違い',
      'detailDescription': '説明',
      'detailHeight': '高さ',
      'detailWeight': '重さ',
      'detailBaseExp': '基本経験値',
      'detailTypes': 'タイプ',
      'detailAbilities': '特性',
      'detailStats': 'ステータス',
      'typeEffectivenessTitle': 'タイプの弱点と有効性',
      'typeEffectivenessLimit': 'タイプは2つまで選択できます。',
      'typeEffectivenessSelectOneOrTwo': 'タイプを1つまたは2つ選択して、弱点と有効性を確認してください。',
      'typeEffectivenessSelectedTypes': '選択されたタイプ: ',
      'typeEffectivenessSelectTypes': '最大2つまでタイプを選択してください:',
      'typeEffectivenessResults': '結果',
      'typeEffectivenessNoSelection': 'まだタイプが選択されていません。',
      'typeEffectivenessWeaknesses': '弱点:',
      'typeEffectivenessNeutral': '通常の効果:',
      'typeEffectivenessResistances': '耐性:',
      'typeEffectivenessTip': 'ヒント: 2つのタイプを選択すると、効果が乗算されて防御が組み合わされます。',
    },
  };

  String t(String key) {
    return _strings[languageCode]?[key] ?? _strings['en']![key] ?? key;
  }

  String get appTitle => t('appTitle');
  String get homeLoadingPokemon => t('homeLoadingPokemon');
  String get drawerHome => t('drawerHome');
  String get drawerTypeEffectiveness => t('drawerTypeEffectiveness');
  String get drawerPreferences => t('drawerPreferences');
  String get drawerDescription => t('drawerDescription');
  String get preferencesTitle => t('preferencesTitle');
  String get preferencesCurrentLanguage => t('preferencesCurrentLanguage');
  String get preferencesDescription => t('preferencesDescription');
  String get preferencesThemeTitle => t('preferencesThemeTitle');
  String get preferencesLight => t('preferencesLight');
  String get preferencesLightSubtitle => t('preferencesLightSubtitle');
  String get preferencesDark => t('preferencesDark');
  String get preferencesDarkSubtitle => t('preferencesDarkSubtitle');
  String get errorPrefix => t('errorPrefix');
  String get detailNormal => t('detailNormal');
  String get detailShiny => t('detailShiny');
  String get detailDescription => t('detailDescription');
  String get detailHeight => t('detailHeight');
  String get detailWeight => t('detailWeight');
  String get detailBaseExp => t('detailBaseExp');
  String get detailTypes => t('detailTypes');
  String get detailAbilities => t('detailAbilities');
  String get detailStats => t('detailStats');
  String get typeEffectivenessTitle => t('typeEffectivenessTitle');
  String get typeEffectivenessLimit => t('typeEffectivenessLimit');
  String get typeEffectivenessSelectOneOrTwo => t('typeEffectivenessSelectOneOrTwo');
  String get typeEffectivenessSelectedTypes => t('typeEffectivenessSelectedTypes');
  String get typeEffectivenessSelectTypes => t('typeEffectivenessSelectTypes');
  String get typeEffectivenessResults => t('typeEffectivenessResults');
  String get typeEffectivenessNoSelection => t('typeEffectivenessNoSelection');
  String get typeEffectivenessWeaknesses => t('typeEffectivenessWeaknesses');
  String get typeEffectivenessNeutral => t('typeEffectivenessNeutral');
  String get typeEffectivenessResistances => t('typeEffectivenessResistances');
  String get typeEffectivenessTip => t('typeEffectivenessTip');

  String languageChangedMessage(String languageName) => '${t('languageChanged')}$languageName';
  String themeChangedMessage(ThemeMode mode) => mode == ThemeMode.dark ? t('themeChangedDark') : t('themeChangedLight');
  String selectedTypesLabel(List<String> selectedTypes) {
    if (selectedTypes.isEmpty) {
      return t('typeEffectivenessSelectOneOrTwo');
    }
    return '${t('typeEffectivenessSelectedTypes')}${selectedTypes.join(' / ')}';
  }
}
