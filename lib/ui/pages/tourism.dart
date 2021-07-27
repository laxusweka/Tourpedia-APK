import 'package:flutter/material.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:tourpedia/models/tourism_model.dart' as tourism_model;
import 'package:tourpedia/models/tourism_model_random.dart' as tourism_random;
import 'package:tourpedia/services/tourism_services.dart';
import 'package:tourpedia/ui/pages/detail.dart';
import 'package:tourpedia/ui/pages/tourism_category.dart';
import 'package:tourpedia/ui/widgets/card_explore.dart';
import 'package:tourpedia/ui/widgets/card_must_see.dart';
import 'package:tourpedia/ui/widgets/custom_header.dart';
import 'package:tourpedia/utils/my_colors.dart';
import 'package:tourpedia/utils/settings.dart';

class Tourism extends StatefulWidget {
  const Tourism({Key? key}) : super(key: key);

  @override
  _TourismState createState() => _TourismState();
}

class _TourismState extends State<Tourism> {
  tourism_model.TourismModel tourismModel = tourism_model.TourismModel(
      data: tourism_model.Data(item: [], favorite: 0, total: 0),
      meta: tourism_model.Meta(code: 0, status: '', message: ''));

  tourism_random.TourismModelRandom tourismModelRandom =
      tourism_random.TourismModelRandom(
          meta: tourism_random.Meta(code: 0, message: '', status: ''),
          data: tourism_random.Data(item: []));

  bool loadingExplore = true;
  bool loadingRandom = true;

  Future<void> getDataTourism() async {
    await TourismServices().getDataTourismExplore().then((value) {
      setState(() {
        tourismModel = value!;
      });
    });
  }

  Future<void> getDataTourismRandom() async {
    await TourismServices().getDataTourismRandom().then((value) {
      setState(() {
        tourismModelRandom = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDataTourismRandom().whenComplete(() => loadingRandom = false);
    getDataTourism().whenComplete(() => loadingExplore = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteSecond,
      body: ListView(
        children: [
          CustomHeader(
            typeCategory: TypeCategory.tourism,
            favoriteTotal: tourismModel.data.favorite,
            itemTotal: tourismModel.data.total,
          ),
          /**
           * Category
           */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TouchableOpacity(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TourismCategory(
                          wisataCategory: WisataCategory.wisataBuatan,
                        ),
                      ));
                },
                child: SizedBox(
                  width: 50,
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Image(
                        height: 33,
                        image: AssetImage(
                            'lib/assets/images/icon_wisata_buatan.png'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Wisata Buatan',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              TouchableOpacity(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TourismCategory(
                          wisataCategory: WisataCategory.wisataAlam,
                        ),
                      ));
                },
                child: SizedBox(
                  width: 50,
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Image(
                        height: 33,
                        image: AssetImage(
                            'lib/assets/images/icon_wisata_alam.png'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Wisata Alam',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              TouchableOpacity(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TourismCategory(
                          wisataCategory: WisataCategory.wisataAir,
                        ),
                      ));
                },
                child: SizedBox(
                  width: 50,
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Image(
                        height: 33,
                        image:
                            AssetImage('lib/assets/images/icon_wisata_air.png'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Wisata Air',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              TouchableOpacity(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TourismCategory(
                          wisataCategory: WisataCategory.wisataBinatang,
                        ),
                      ));
                },
                child: SizedBox(
                  width: 50,
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Image(
                        height: 33,
                        image: AssetImage(
                            'lib/assets/images/icon_wisata_binatang.png'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Wisata Binatang',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
            child: Text(
              'Rekomendasi',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // ignore: sized_box_for_whitespace
          Container(
            height: 200,
            child: (loadingRandom)
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: tourismModelRandom.data.item.length,
                    itemBuilder: (context, index) => CardMustSee(
                          image: tourismModelRandom
                              .data.item[index].images[0].linkImage,
                          title: tourismModelRandom.data.item[index].title,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Detail(
                                      id: tourismModelRandom
                                          .data.item[index].id),
                                ));
                          },
                        )),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Text(
              'Explore',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          (loadingExplore)
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: tourismModel.data.item.length,
                  itemBuilder: (context, index) => CardExplore(
                    imageURL: Settings.urlBackend +
                        '/storage/' +
                        tourismModel.data.item[index].images[0].linkImage,
                    isFavorite: false,
                    name: tourismModel.data.item[index].title,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Detail(id: tourismModel.data.item[index].id),
                          ));
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
