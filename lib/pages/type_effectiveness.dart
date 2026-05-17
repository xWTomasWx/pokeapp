import 'package:flutter/material.dart';
import '../data/services/pokemon_service.dart';

class TypeEffectivenessPage extends StatefulWidget {
  final String languageCode;

  const TypeEffectivenessPage({
    super.key,
    required this.languageCode,
  });

  @override
  State<TypeEffectivenessPage> createState() => _TypeEffectivenessPageState();
}

class _TypeEffectivenessPageState extends State<TypeEffectivenessPage> {
  final PokemonService _pokemonService = PokemonService();
  final List<String> selectedTypes = [];
  final Map<String, Map<String, double>> typeChart = {};
  final List<String> allTypes = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTypeChart();
  }

  Future<void> _loadTypeChart() async {
    try {
      final chart = await _pokemonService.fetchTypeEffectivenessChart(
        languageCode: widget.languageCode,
      );
      setState(() {
        typeChart.clear();
        typeChart.addAll(chart);
        allTypes.clear();
        allTypes.addAll(typeChart.keys.toList()..sort());
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _toggleTypeSelection(String type) {
    setState(() {
      if (selectedTypes.contains(type)) {
        selectedTypes.remove(type);
      } else if (selectedTypes.length < 2) {
        selectedTypes.add(type);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Solo puedes seleccionar hasta 2 tipos.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    });
  }

  double _multiplierForAttackType(String attackType) {
    var multiplier = 1.0;
    for (final defender in selectedTypes) {
      multiplier *= typeChart[attackType]?[defender] ?? 1.0;
    }
    return multiplier;
  }

  Map<String, double> get _currentEffectiveness {
    return Map.fromEntries(
      allTypes.map(
        (attackType) => MapEntry(attackType, _multiplierForAttackType(attackType)),
      ),
    );
  }

  Widget _buildTypeChip(String type) {
    final isSelected = selectedTypes.contains(type);
    return ChoiceChip(
      label: Text(type),
      selected: isSelected,
      onSelected: (_) => _toggleTypeSelection(type),
      selectedColor: Colors.deepPurple.shade300,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
    );
  }

  Widget _buildEffectivenessChips(List<String> types, Color color) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: types
          .map(
            (type) => Chip(
              label: Text(type),
              backgroundColor: color,
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Debilidades y Eficacias de Tipos'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Debilidades y Eficacias de Tipos'),
        ),
        body: Center(child: Text('Error: $_error')),
      );
    }

    final effectiveness = _currentEffectiveness;
    final superEffective = effectiveness.entries
        .where((entry) => entry.value > 1)
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final notEffective = effectiveness.entries
        .where((entry) => entry.value < 1)
        .toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    final neutral = effectiveness.entries
        .where((entry) => entry.value == 1)
        .toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    final selectedLabel = selectedTypes.isEmpty
        ? 'Selecciona 1 o 2 tipos para ver debilidades y efectividades.'
        : 'Tipos seleccionados: ${selectedTypes.join(' / ')}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debilidades y Eficacias de Tipos'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            selectedLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12.0),
          const Text('Selecciona hasta dos tipos:'),
          const SizedBox(height: 12.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: allTypes.map(_buildTypeChip).toList(),
          ),
          const SizedBox(height: 24.0),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resultados',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12.0),
                  if (selectedTypes.isEmpty)
                    const Text('Aún no has seleccionado ningún tipo.')
                  else ...[
                    const Text('Debilidades:'),
                    const SizedBox(height: 8.0),
                    _buildEffectivenessChips(
                      superEffective.map((entry) {
                        final value = entry.value;
                        final label = value == 4
                            ? '${entry.key} x4'
                            : value == 2
                                ? '${entry.key} x2'
                                : '${entry.key} x${value.toStringAsFixed(2)}';
                        return label;
                      }).toList(),
                      const Color.fromRGBO(244, 67, 54, 0.15),
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Eficacias neutrales:'),
                    const SizedBox(height: 8.0),
                    _buildEffectivenessChips(
                      neutral.map((entry) => '${entry.key} x1').toList(),
                      const Color.fromRGBO(158, 158, 158, 0.15),
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Resistencias:'),
                    const SizedBox(height: 8.0),
                    _buildEffectivenessChips(
                      notEffective.map((entry) {
                        final value = entry.value;
                        final label = value == 0.5
                            ? '${entry.key} x1/2'
                            : value == 0.25
                                ? '${entry.key} x1/4'
                                : value == 0
                                    ? '${entry.key} x0'
                                    : '${entry.key} x${value.toStringAsFixed(2)}';
                        return label;
                      }).toList(),
                      const Color.fromRGBO(76, 175, 80, 0.15),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          const Text(
            'Consejo: si seleccionas dos tipos, el resultado combina ambas defensas multiplicando la eficacia.',
            style: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
