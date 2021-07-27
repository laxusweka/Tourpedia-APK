import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:tourpedia/utils/my_colors.dart';

class CustomButtonSmall extends StatelessWidget {
  final GestureTapCallback onTap;
  final String title;

  const CustomButtonSmall({Key? key, required this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: MyColors.white,
            ),
          ),
        ),
        width: MediaQuery.of(context).size.width - 100,
        height: 50,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: MyColors.button,
        ),
      ),
    );
  }
}
