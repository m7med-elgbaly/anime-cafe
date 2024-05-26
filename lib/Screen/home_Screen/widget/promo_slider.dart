import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../common/widgets/image/image_slider.dart';
import '../../../models/anime.dart';
import '../../../utlis/constanst/colors.dart';
import '../../controller/home_controller.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({
    super.key,
    required this.controller,
    required this.high,
    required this.width,
    required this.rankingType,
  });

  final HomeController controller;
  final double high;
  final double width;
  final String rankingType;

  @override
  Widget build(BuildContext context) {
    List<Anime> animeList = controller.animeLists[rankingType] ?? [];
    return Obx(
          () => Stack(
        children: [
          CarouselSlider.builder(
              carouselController: controller.buttonCarouselController,
              itemCount: animeList.length,
              itemBuilder: (context, index, realIndex) {
                var anime = animeList[index];

                return ImageSlider(high: high, anime: anime, controller: controller);
              },
              options: CarouselOptions(
                  height: high * 0.55,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    controller.setPage(index);
                  })),
          Column(
            children: [
              SizedBox(
                height: high * 0.29,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(animeList.length, (index) {
                    return Container(
                      height: 4,
                      width: 20,
                      margin: const EdgeInsets.only(
                        right: 10,
                      ),
                      padding: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(400),
                        color: controller.currentIndex.value == index
                            ? Colors.white
                            : AColors.secondary,
                      ),
                    );
                  })),
              SizedBox(
                height: high * 0.18,
              ),
              Container(
                  width: width * 0.9,
                  height: high * 0.095,
                  padding: const EdgeInsets.only(top: 2, left: 14, right: 14),
                  decoration: BoxDecoration(
                    color:AColors.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () {},
                      icon: const Column(children: [Icon(Icons.add,),Text('Add List',style: TextStyle(fontSize: 10, color: AColors.textColor, fontWeight: FontWeight.bold),)],),),
                      SizedBox(
                        height: 30,
                        child: IconButton(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            padding: const EdgeInsets.only(bottom: 4, right: 10, left: 5, top: 4),
                            backgroundColor: AColors.secondary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          icon: const Row(
                            children: [
                              Icon(Icons.play_arrow,size: 18,color: AColors.textColor,),
                              Text(
                                'Play',
                                style: TextStyle(color: AColors.textColor, fontSize: 12 ,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      IconButton(onPressed: () {}, icon:  const Column(children: [Icon(Icons.download,),Text('Download',style: TextStyle(fontSize: 10, color: AColors.textColor, fontWeight: FontWeight.bold),)])),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}