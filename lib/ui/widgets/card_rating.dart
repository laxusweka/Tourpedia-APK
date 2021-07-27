import 'package:flutter/material.dart';
import 'package:tourpedia/ui/widgets/stars_in_rating.dart';
import 'package:tourpedia/utils/my_colors.dart';

class CardRating extends StatelessWidget {
  const CardRating({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: MyColors.greyOne,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const StarsInRating(rating: 3),
              const Text(' Oleh '),
              const Text('XXXXXXXX'),
            ],
          ),
          const SizedBox(height: 5),
          const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Eu imperdiet mi arcu elit facilisi sed. Neque, auctor elementum arcu aliquet id diam porta feugiat volutpat. Et.'),
        ],
      ),
    );
  }
}
