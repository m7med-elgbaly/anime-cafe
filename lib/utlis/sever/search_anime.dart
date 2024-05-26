
import '../../models/anime.dart';
import 'anime_repository.dart';

class SearchAnime {
  final AnimeRepository repository;

  SearchAnime(this.repository);

  Future<List<Anime>> call(String query, {int page = 1}) async {
    return await repository.searchAnime(query, page: page);
  }
}