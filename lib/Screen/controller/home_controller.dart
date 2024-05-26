import 'package:anime_plant/models/anime.dart';
import 'package:anime_plant/utlis/api_servic.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final isLoading = true.obs;
  final currentIndex = 0.obs;
  final animeLists = <String, List<Anime>>{}.obs;
  final errorMessage = ''.obs;

  final AnimeApi _apiService = AnimeApi();
  final CarouselSliderController buttonCarouselController =
      CarouselSliderController();

  @override
  void onInit() {
    fetchTrendingAnime('all', 5);
    super.onInit();
  }

  void fetchTrendingAnime(String rankingType, int limit) async {
    if (animeLists[rankingType] != null) return;
    try {
      isLoading(true);
      errorMessage('');
      List<Anime> animeList = await _apiService.fetchTrendingAnime(
          rankingType: rankingType, limit: limit);
      animeLists[rankingType] = animeList;
    } catch (e) {
      errorMessage('Failed to load anime list: $e');
    } finally {
      isLoading(false);
    }
  }

  void nextPage() {
    buttonCarouselController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void previousPage() {
    buttonCarouselController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void setPage(int index) {
    currentIndex.value = index;
  }
}
