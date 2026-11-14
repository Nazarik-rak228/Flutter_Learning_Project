// api_service.dart
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class ApiService {
  final Dio _dio = GetIt.instance<Dio>();

  Future<List<dynamic>> fetchCovidData({
    required String country,
    String type = 'cases',
  }) async {
    try {
      final response = await _dio.get(
        '/covid19',
        queryParameters: {
          'country': country,
          'type': type,
        },
      );
      return response.data as List<dynamic>;
    } on DioException catch (e) {
      throw Exception(
        e.response?.data?['error']?.toString() ??
            e.message ??
            'Ошибка при загрузке данных',
      );
    }
  }
}