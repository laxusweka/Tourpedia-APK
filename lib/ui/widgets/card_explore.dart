import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:tourpedia/utils/my_colors.dart';

// ignore: must_be_immutable
class CardExplore extends StatefulWidget {
  final GestureTapCallback onTap;
  final String imageURL;
  final String name;
  bool isFavorite;
  CardExplore(
      {Key? key,
      required this.imageURL,
      required this.name,
      required this.isFavorite,
      required this.onTap})
      : super(key: key);

  @override
  State<CardExplore> createState() => _CardExploreState();
}

class _CardExploreState extends State<CardExplore> {
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: widget.onTap,
      // ignore: avoid_unnecessary_containers
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        child: Stack(
          children: [
            Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color: MyColors.greySecond,
                image: DecorationImage(
                  image: NetworkImage(widget.imageURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: MyColors.bluePrimary.withOpacity(0.75),
                ),
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    color: MyColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
