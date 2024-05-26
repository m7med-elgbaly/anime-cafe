import 'package:flutter/material.dart';

import '../../../common/widgets/image/image_container.dart';
import '../../../models/anime.dart';
import '../../../utlis/constanst/colors.dart';
import '../../../utlis/constanst/size.dart';
import '../../controller/home_controller.dart';

class AnimeList extends StatelessWidget {
  const AnimeList({
    super.key,
    required this.high,
    required this.controller,
    required this.width,
    required this.rankingType, required this.title,
  });

  final double high;
  final HomeController controller;
  final double width;
  final String rankingType;
  final String title;

  @override
  Widget build(BuildContext context) {
    List<Anime> animeList = controller.animeLists[rankingType] ?? [];
    return Padding(
      padding: const EdgeInsets.all(ASize.sm),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    color: AColors.textColor,
                    fontWeight: FontWeight.bold),
              ),
              TextButton(
                  onPressed: () {},
                  child: const Text('Show more',
                      style: TextStyle(
                        fontSize: 16,
                        color: AColors.textColor,
                      )))
            ],
          ),
          const SizedBox(
            height: ASize.xs,
          ),
          SizedBox(
            height: high * 0.29,
            child: ListView.builder(
                itemCount: animeList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  var anime = animeList[index];
                  return Stack(
                    children: [
                      ImageContainer(
                        high: high * 0.30,
                        width: width * 0.35,
                        imageUrl: anime.imageUrl,
                        isNetWorking: true,
                        fit: BoxFit.cover,
                        radius: 15,
                        margin: const EdgeInsets.only(left: ASize.xs),
                        title: anime.title,
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}