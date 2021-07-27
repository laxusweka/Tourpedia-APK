import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:tourpedia/utils/my_colors.dart';

class CustomButtonLogin extends StatelessWidget {
  final GestureTapCallback onTap;
  final String title;

  const CustomButtonLogin({Key? key, required this.onTap, required this.title})
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
        width: MediaQuery.of(context).size.width - 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            border: Border.all(
              color: MyColors.button,
              width: 2,
            )),
      ),
    );
  }
}
