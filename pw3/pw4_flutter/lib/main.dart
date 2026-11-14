// main.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_service.dart';
import 'interceptors.dart';

const String apiKey = 'SRLTy28NGHkpQNqlPvklQak1sm2Nhzr0tDq5IYmK';

void main() {
  final getIt = GetIt.instance;

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://api.api-ninjas.com/v1/',
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );

  dio.interceptors.add(InterceptorsApp(apiKey));
  dio.interceptors.add(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ),
  );

  getIt.registerSingleton<Dio>(dio);
  getIt.registerSingleton<ApiService>(ApiService());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid-19 Stats',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
      ),
      home: const CovidPage(),
    );
  }
}

class CovidPage extends StatefulWidget {
  const CovidPage({super.key});

  @override
  State<CovidPage> createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  final ApiService _api = GetIt.instance<ApiService>();
  final TextEditingController _countryController =
      TextEditingController(text: 'Russia');

  String _type = 'cases';
  List<dynamic>? _data;
  bool _isLoading = false;
  String? _error;

  Future<void> _loadData() async {
    final country = _countryController.text.trim();
    if (country.isEmpty) {
      setState(() => _error = 'Введите название страны');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
      _data = null;
    });

    try {
      final result = await _api.fetchCovidData(
        country: country,
        type: _type,
      );
      setState(() {
        _data = result;
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
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Covid-19 Статистика'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _loadData,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _countryController,
              decoration: const InputDecoration(
                labelText: 'Страна (на английском)',
                hintText: 'Russia, United States, Germany...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.public),
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (_) => _loadData(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(
                        value: 'cases',
                        label: Text('Заболевания'),
                        icon: Icon(Icons.coronavirus),
                      ),
                      ButtonSegment(
                        value: 'deaths',
                        label: Text('Смерти'),
                        icon: Icon(Icons.heart_broken),
                      ),
                    ],
                    selected: {_type},
                    onSelectionChanged: (Set<String> newSelection) {
                      setState(() => _type = newSelection.first);
                      _loadData();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _loadData,
              icon: _isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.search),
              label: Text(_isLoading ? 'Загрузка...' : 'Получить данные'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading && _data == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: _loadData,
              child: const Text('Повторить'),
            ),
          ],
        ),
      );
    }

    if (_data == null || _data!.isEmpty) {
      return Center(
        child: Text(
          _type == 'deaths'
              ? 'Нет данных по смертям для этой страны'
              : 'Нет данных. Попробуйте другую страну.',
        ),
      );
    }

    return ListView.builder(
      itemCount: _data!.length,
      itemBuilder: (context, index) {
        final item = _data![index] as Map<String, dynamic>;
        final country = item['country'] ?? '—';
        final region = item['region'];
        final casesMap = (item['cases'] ?? item['deaths'])
        as Map<String, dynamic>? ??
    {};

if (casesMap.isEmpty) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        'Для ${item['country']} API не вернул временной ряд. '
        'Доступные поля: ${item.keys.join(', ')}',
      ),
    ),
  );
}

        String? latestDate;
        Map<String, dynamic>? latestData;

        final dates = casesMap.keys.toList()..sort();

        for (int i = dates.length - 1; i >= 0; i--) {
          final date = dates[i];
          final dayData = casesMap[date] as Map<String, dynamic>?;
          final total = dayData?['total'];

          if (total is num && total > 0) {
            latestDate = date;
            latestData = dayData;
            break;
          }
        }

        if (latestDate == null) {
          latestDate = dates.last;
          latestData = casesMap[latestDate] as Map<String, dynamic>?;
        }

        final total = latestData?['total'] ?? 0;
        final newCases = latestData?['new'] ?? 0;

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  region != null ? '$country — $region' : country,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                if (latestDate != null)
                  Text(
                    'Последние данные: $latestDate',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _statBox(
                        title: _type == 'cases' ? 'Всего случаев' : 'Всего смертей',
                        value: _formatNumber(total),
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _statBox(
                        title: _type == 'cases' ? 'Новых' : 'Новых смертей',
                        value: _formatNumber(newCases),
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _statBox({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color.withValues(alpha: 0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(dynamic number) {
    if (number is int) {
      return number.toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]} ',
          );
    }
    return number.toString();
  }
}
