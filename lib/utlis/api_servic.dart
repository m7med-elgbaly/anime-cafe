import 'dart:convert';

import 'package:anime_plant/utlis/constanst/api.dart';
import 'package:http/http.dart' as http;
import '../models/anime.dart';

class AnimeApi{
  final String baseUrl = 'https://api.myanimelist.net/v2';
  final String clientId = apiKey;

  Future<List<Anime>> fetchTrendingAnime({
    required String rankingType,
    required int limit,
}) async {

    final response = await http.get(
      Uri.parse('$baseUrl/anime/ranking?ranking_type=$rankingType&fields=genres,mean,main_picture&limit=$limit'),
      headers: {
        'X-MAL-Client-ID': clientId,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((anime) => Anime.formJson(anime['node'])).toList();
    } else {
      throw Exception('Failed to load anime');
    }
  }
}