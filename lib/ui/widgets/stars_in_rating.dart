import 'package:flutter/material.dart';
import 'package:tourpedia/utils/my_colors.dart';

class StarsInRating extends StatelessWidget {
  final int rating;
  const StarsInRating({Key? key, required this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Icon(
          Icons.star_rounded,
          size: 20,
          color:
              (rating >= 1) ? MyColors.button : MyColors.black.withOpacity(0.2),
        ),
        Icon(
          Icons.star_rounded,
          size: 20,
          color:
              (rating >= 2) ? MyColors.button : MyColors.black.withOpacity(0.2),
        ),
        Icon(
          Icons.star_rounded,
          size: 20,
          color:
              (rating >= 3) ? MyColors.button : MyColors.black.withOpacity(0.2),
        ),
        Icon(
          Icons.star_rounded,
          size: 20,
          color:
              (rating >= 4) ? MyColors.button : MyColors.black.withOpacity(0.2),
        ),
        Icon(
          Icons.star_rounded,
          size: 20,
          color:
              (rating >= 5) ? MyColors.button : MyColors.black.withOpacity(0.2),
        ),
      ],
    );
  }
}
