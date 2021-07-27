import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tourpedia/ui/widgets/custom_search_bar.dart';
import 'package:tourpedia/utils/my_colors.dart';

enum TypeCategory { tourism, culinary }

class CustomHeader extends StatefulWidget {
  final int itemTotal;
  final int favoriteTotal;
  final TypeCategory typeCategory;
  const CustomHeader(
      {Key? key,
      required this.typeCategory,
      required this.itemTotal,
      required this.favoriteTotal})
      : super(key: key);

  @override
  _CustomHeaderState createState() => _CustomHeaderState();
}

class _CustomHeaderState extends State<CustomHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: const BoxDecoration(
          color: MyColors.bluePrimary,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /**
               * SEARCH
               */
          CustomSearchBar(
            typeCategory: widget.typeCategory,
          ),
          /**
               * TOURISM BANDUNG
               */
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(fontSize: 24, color: MyColors.black),
                children: [
                  TextSpan(
                      text: (widget.typeCategory == TypeCategory.tourism)
                          ? "Tourism in "
                          : "Culinary in "),
                  const TextSpan(
                      text: "BANDUNG",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.blueSecondary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
