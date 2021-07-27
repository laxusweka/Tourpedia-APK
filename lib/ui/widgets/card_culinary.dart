import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:tourpedia/utils/my_colors.dart';

// ignore: must_be_immutable
class CardCulinary extends StatefulWidget {
  final GestureTapCallback onTap;
  final String imageURL;
  final String name;
  final String alamat;
  final double bottom;

  const CardCulinary({
    Key? key,
    required this.onTap,
    required this.imageURL,
    required this.name,
    required this.alamat,
    this.bottom = 0,
  }) : super(key: key);

  @override
  State<CardCulinary> createState() => _CardCulinaryState();
}

class _CardCulinaryState extends State<CardCulinary> {
  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onTap: widget.onTap,
      // ignore: avoid_unnecessary_containers
      child: Container(
        margin: EdgeInsets.only(bottom: widget.bottom),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 0.0,
              spreadRadius: 1.0,
              offset: const Offset(1, 2.0), // shadow direction: bottom right
            )
          ],
        ),
        //margin: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          children: [
            Container(
              height: 96,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                color: MyColors.greySecond,
                image: DecorationImage(
                  image: NetworkImage(widget.imageURL),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                color: Colors.white,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 5, left: 7, right: 7, bottom: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      widget.alamat,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: MyColors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
