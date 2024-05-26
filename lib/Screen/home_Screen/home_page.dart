import 'package:anime_plant/Screen/controller/home_controller.dart';
import 'package:anime_plant/Screen/home_Screen/widget/anime_list.dart';
import 'package:anime_plant/Screen/home_Screen/widget/promo_slider.dart';
import 'package:anime_plant/utlis/constanst/colors.dart';
import 'package:anime_plant/utlis/constanst/size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/appbar/anime_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController controller = Get.put(HomeController());
  final CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    controller.fetchTrendingAnime('movie', 5);
    controller.fetchTrendingAnime('bypopularity', 10);
    controller.fetchTrendingAnime('tv', 10);
  }

  @override
  Widget build(BuildContext context) {
    final high = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AColors.primary,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    PromoSlider(
                      controller: controller,
                      high: high,
                      width: width,
                      rankingType: 'movie',
                    ),
                    AnimeAppBar(),
                  ],
                ),
                const SizedBox(
                  height: ASize.xs,
                ),
                AnimeList(
                  title: 'Trending Now',
                  high: high,
                  controller: controller,
                  width: width,
                  rankingType: 'bypopularity',
                ),
                const SizedBox(
                  height: ASize.xs,
                ),
                AnimeList(
                  title: 'popular',
                  high: high,
                  controller: controller,
                  width: width,
                  rankingType: 'tv',
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
