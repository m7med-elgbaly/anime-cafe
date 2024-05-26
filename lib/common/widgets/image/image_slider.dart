import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../Screen/controller/home_controller.dart';
import '../../../models/anime.dart';
import '../../../utlis/constanst/colors.dart';
import '../../../utlis/constanst/size.dart';
import 'image_container.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({
    super.key,
    required this.high,
    required this.anime,
    required this.controller,
  });

  final double high;
  final Anime anime;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageContainer(
          high: high * 0.52,
          width: double.infinity,
          imageUrl: anime.imageUrl,
          fit: BoxFit.fill,
          isNetWorking: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: ASize.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: high * 0.150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => controller.previousPage(),
                      icon: const Icon(
                        Iconsax.arrow_left_2,
                        color: AColors.textColor,
                        size: 50,
                      )),
                  IconButton(
                      onPressed: () => controller.nextPage(),
                      icon: const Icon(
                        Iconsax.arrow_right_3,
                        color: AColors.textColor,
                        size: 50,
                      )),
                ],
              ),
              const SizedBox(
                height: ASize.spaceBtwSections,
              ),
              const SizedBox(
                height: ASize.spaceBtwItems,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Text(
                      maxLines: 1,
                      anime.title,
                      style: const TextStyle(
                          fontSize: 18,
                          color: AColors.textColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 55,
                      height: 20,
                      decoration: BoxDecoration(
                          color: Colors.yellowAccent,
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.black,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            anime.rating.toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: ASize.spaceBtwItems,
              ),
              Flexible(
                flex: 1,
                child: Text(
                  maxLines: 1,
                  anime.genres.join(' - '),
                  textAlign: TextAlign.start,
                  style:
                  const TextStyle(fontSize: 12, color: AColors.textColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}