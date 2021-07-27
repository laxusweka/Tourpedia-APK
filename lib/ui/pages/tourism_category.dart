import 'package:flutter/material.dart';
import 'package:tourpedia/models/search_tourism_model.dart';
import 'package:tourpedia/services/search_services.dart';
import 'package:tourpedia/ui/pages/detail.dart';
import 'package:tourpedia/ui/widgets/card_explore.dart';
import 'package:tourpedia/utils/my_colors.dart';
import 'package:tourpedia/utils/settings.dart';

enum WisataCategory { wisataBuatan, wisataAlam, wisataAir, wisataBinatang }

class TourismCategory extends StatefulWidget {
  final WisataCategory wisataCategory;

  const TourismCategory({Key? key, required this.wisataCategory})
      : super(key: key);

  @override
  _TourismCategoryState createState() => _TourismCategoryState();
}

class _TourismCategoryState extends State<TourismCategory> {
  SearchTourismModel searchTourismModel = SearchTourismModel(
      meta: Meta(code: 0, message: '', status: ''), data: Data(data: []));

  bool loading = true;

  Future<void> getDataCategory() async {
    await SearchServices()
        .getDataDestinationsCategory(titleAppbar(widget.wisataCategory))
        .then((value) {
      setState(() {
        searchTourismModel = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDataCategory().whenComplete(() => loading = false);
  }

  String titleAppbar(WisataCategory wisataCategory) {
    if (wisataCategory == WisataCategory.wisataBuatan) {
      return 'Wisata Buatan';
    }
    if (wisataCategory == WisataCategory.wisataAlam) {
      return 'Wisata Alam';
    }
    if (wisataCategory == WisataCategory.wisataAir) {
      return 'Wisata Air';
    }
    return 'Wisata Binatang';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.bluePrimary,
        title: Text(titleAppbar(widget.wisataCategory)),
      ),
      body: (loading)
          ? const Center(child: CircularProgressIndicator())
          : (searchTourismModel.data.data.isEmpty)
              ? const Center(child: Text('Data tidak ada'))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: searchTourismModel.data.data.length,
                  itemBuilder: (context, index) => CardExplore(
                    imageURL: Settings.urlBackend +
                        '/storage/' +
                        searchTourismModel.data.data[index].images[0].linkImage,
                    isFavorite: false,
                    name: searchTourismModel.data.data[index].title,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Detail(
                                id: searchTourismModel.data.data[index].id),
                          ));
                    },
                  ),
                ),
    );
  }
}
