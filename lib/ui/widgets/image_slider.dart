import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tourpedia/utils/my_colors.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({Key? key, required this.images}) : super(key: key);
  final List<String> images;

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Stack(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height / 2,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(
                  () {
                    _current = index;
                  },
                );
              },
              // autoPlay: false,
            ),
            items: widget.images
                .map(
                  (item) => Container(
                    color: MyColors.greySecond,
                    child: Center(
                        child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height / 2,
                    )),
                  ),
                )
                .toList(),
          ),
          /**
             * TITIK TITIK
             */
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.images.map(
                    (data) {
                      int index = widget.images.indexOf(data);
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? const Color.fromRGBO(255, 255, 255, 0.9)
                              : const Color.fromRGBO(255, 255, 255, 0.4),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
