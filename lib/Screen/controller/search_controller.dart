
import 'package:anime_plant/models/anime.dart';
import 'package:anime_plant/utlis/api_search.dart';
import 'package:get/get.dart';



class SearchControllers extends GetxController {
  final SearchApiService _apiService = SearchApiService();
  RxList<Anime> animeList = <Anime>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;
  RxString searchQuery = ''.obs;
  RxBool hasSearchResults = false.obs;
  RxInt currentPage = 1.obs;
  final int limit = 20;

  void setSearchQuery(String query) {
    searchQuery.value = query;
    currentPage.value = 1;
  }

  Future<void> resetAndSearch() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';
    animeList.clear();
    hasSearchResults.value = false;

    try {
      List<Anime> results = await performSearch(searchQuery.value);
      animeList.assignAll(results);
      hasSearchResults.value = animeList.isNotEmpty;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreResults() async {
    if (isLoading.value) return;

    isLoading.value = true;
    try {
      currentPage.value++;
      List<Anime> moreResults = await performSearch(searchQuery.value, page: currentPage.value);
      animeList.addAll(moreResults);
    } catch (e) {
      hasError.value = true;
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void clearSearch() {
    animeList.clear();
    searchQuery.value = '';
    hasSearchResults.value = false;
    currentPage.value = 1;
  }

  Future<List<Anime>> performSearch(String query, {int page = 1}) async {
    try {
      return await _apiService.searchAnime(query, page: page, limit: limit);
    } catch (e) {
      throw Exception('Error performing search: $e');
    }
  }
}

