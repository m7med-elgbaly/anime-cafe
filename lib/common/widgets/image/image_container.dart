import 'package:flutter/material.dart';

import '../../../utlis/constanst/colors.dart';
import '../../../utlis/constanst/size.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.high,
    this.width,
    this.isNetWorking = false,
    required this.imageUrl,
    this.opPressed,
    this.fit, this.margin, this.radius = 0, this.title ='',
  });

  final double? high, width ;
  final bool isNetWorking;
  final String imageUrl;
  final VoidCallback? opPressed;
  final BoxFit? fit;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: opPressed,
        child: Container(
          width: width,
          height: high,
          margin: margin,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
              image: DecorationImage(
                  fit: fit,
                  image: isNetWorking
                      ? NetworkImage(imageUrl)
                      : AssetImage(imageUrl) as ImageProvider)),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.9), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: ASize.sm ,left: ASize.xs),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(title, style: const TextStyle(
                      fontSize: 14,
                      color: AColors.textColor,
                      fontWeight: FontWeight.bold), maxLines: 1,),
                ],
              ),
            ),
          ),
        ));
  }
}