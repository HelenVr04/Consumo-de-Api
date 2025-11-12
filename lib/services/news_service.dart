import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = dotenv.env['NEWS_API_KEY'] ?? '';

  Future<List<dynamic>> fetchNews(String country) async {
    final uri = Uri.https('newsapi.org', '/v2/top-headlines', {
      'country': country,
      'apiKey': apiKey,
    });

    try {
      final response = await http.get(uri).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final articles = data['articles'] as List;
        return articles;
      } else if (response.statusCode == 429) {
        throw Exception('Demasiadas solicitudes (429)');
      } else {
        throw Exception('Error HTTP ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('Error de conexión');
    } on FormatException {
      throw Exception('Error al procesar los datos');
    } on Exception catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }
}
