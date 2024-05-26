import '../../models/anime.dart';
import '../api_search.dart';

abstract class AnimeRepository {
  Future<List<Anime>> searchAnime(String query, {int page = 1});
}


class AnimeRepositoryImpl implements AnimeRepository {
  final SearchApiService remoteDataSource;

  AnimeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Anime>> searchAnime(String query, {int page = 1}) async {
    return await remoteDataSource.searchAnime(query, page: page);
  }
}