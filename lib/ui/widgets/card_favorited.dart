import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:tourpedia/utils/my_colors.dart';

class CardFavorited extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  const CardFavorited({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: MyColors.black.withOpacity(0.5),
              offset: const Offset(4, 4),
              blurRadius: 10,
            )
          ],
        ),
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.favorite, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
