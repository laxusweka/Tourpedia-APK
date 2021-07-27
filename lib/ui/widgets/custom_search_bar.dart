import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tourpedia/ui/pages/search_culinary.dart';
import 'package:tourpedia/ui/pages/search_tourism.dart';
import 'package:tourpedia/ui/widgets/custom_header.dart';
import 'package:tourpedia/utils/my_colors.dart';

class CustomSearchBar extends StatefulWidget {
  final TypeCategory typeCategory;

  const CustomSearchBar({Key? key, required this.typeCategory})
      : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
            color: MyColors.whiteThird,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: const EdgeInsets.only(top: 20, bottom: 10),
        padding: const EdgeInsets.only(left: 15, right: 15),
        width: MediaQuery.of(context).size.width - 40,
        child: TextField(
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search',
            icon: Icon(Icons.search),
          ),
          controller: textEditingController,
          onSubmitted: (value) {
            (widget.typeCategory == TypeCategory.culinary)
                ? Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchCulinary(text: value),
                    ))
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchTourism(text: value),
                    ));
          },
        ),
      ),
    );
  }
}
