import 'package:flutter/material.dart';
import '../localization/app_localizations.dart';
import '../data/services/pokemon_service.dart';

class AbilityDetailPage extends StatefulWidget {
  final String abilityName;
  final String languageCode;

  const AbilityDetailPage({
    super.key,
    required this.abilityName,
    required this.languageCode,
  });

  @override
  State<AbilityDetailPage> createState() => _AbilityDetailPageState();
}

class _AbilityDetailPageState extends State<AbilityDetailPage> {
  final PokemonService _pokemonService = PokemonService();
  Map<String, dynamic>? _abilityDetail;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadAbilityDetail();
  }

  Future<void> _loadAbilityDetail() async {
    try {
      final detail = await _pokemonService.fetchAbilityDetail(
        widget.abilityName,
        languageCode: widget.languageCode,
      );
      setState(() {
        _abilityDetail = detail;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations(widget.languageCode);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.abilityName),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text('${localizations.errorPrefix}$_error'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with ability name and ID
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
                              Theme.of(context).colorScheme.secondary.withValues(alpha: 0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.flash_on,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 32,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.abilityName,
                                        style: Theme.of(context).textTheme.headlineSmall,
                                      ),
                                      if (_abilityDetail?['id'] != null)
                                        Text(
                                          'ID: ${_abilityDetail!['id']}',
                                          style: Theme.of(context).textTheme.bodySmall,
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Short Effect
                      if (_abilityDetail?['shortEffect'] != null) ...[
                        Text(
                          'Efecto Rápido',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(_abilityDetail!['shortEffect'] as String),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Full Description
                      if (_abilityDetail?['description'] != null) ...[
                        Text(
                          'Descripción Completa',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: isDark
                                ? Colors.grey[800]?.withValues(alpha: 0.5)
                                : Colors.grey[200]?.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _abilityDetail!['description'] as String? ?? 'Sin descripción disponible',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],

                      // Additional Info
                      if (_abilityDetail?['generation'] != null || _abilityDetail?['isMainSeries'] != null) ...[
                        Text(
                          'Información Adicional',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        if (_abilityDetail?['generation'] != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Generación:',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        )),
                                Text(
                                  _capitalize(_abilityDetail!['generation'] as String),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        if (_abilityDetail?['isMainSeries'] != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Serie Principal:',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        )),
                                Chip(
                                  label: Text(
                                    _abilityDetail!['isMainSeries'] == true ? 'Sí' : 'No',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: _abilityDetail!['isMainSeries'] == true
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ],
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
    );
  }

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }
}
