import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/anime.dart';
import 'constanst/api.dart';

class SearchApiService {
  static const String _baseUrl = 'https://api.myanimelist.net/v2';
  static const String _apiKey = apiKey; // Replace with your API key

  Future<List<Anime>> searchAnime(String query, {int page = 1, int limit = 20}) async {
    try {
      final offset = (page - 1) * limit;
      final url = Uri.parse('$_baseUrl/anime?q=$query&limit=$limit&offset=$offset');

      final response = await http.get(
        url,
        headers: {
          'X-MAL-CLIENT-ID': _apiKey,
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> animeData = data['data'];

        return animeData.map((item) {
          final node = item['node'];
          return Anime.formJson(node);
        }).toList();
      } else {
        throw Exception('Failed to load anime data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error searching anime: $e');
    }
  }
}