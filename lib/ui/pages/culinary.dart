import 'package:flutter/material.dart';
import 'package:tourpedia/models/culinaries_explore_model.dart';
import 'package:tourpedia/models/culinaries_random_model.dart'
    as culinaries_random;
import 'package:tourpedia/services/culinary_services.dart';
import 'package:tourpedia/ui/pages/detail_culinary.dart';
import 'package:tourpedia/ui/widgets/card_culinary.dart';
import 'package:tourpedia/ui/widgets/card_must_see.dart';
import 'package:tourpedia/ui/widgets/custom_header.dart';
import 'package:tourpedia/utils/my_colors.dart';
import 'package:tourpedia/utils/settings.dart';

class Culinary extends StatefulWidget {
  const Culinary({Key? key}) : super(key: key);

  @override
  _CulinaryState createState() => _CulinaryState();
}

class _CulinaryState extends State<Culinary> {
  CulinariesExploreModel culinariesExploreModel = CulinariesExploreModel(
      meta: Meta(code: 0, status: '', message: ''),
      data: Data(favorite: 0, item: [], total: 0));

  culinaries_random.CulinariesRandomModel culinariesRandomModel =
      culinaries_random.CulinariesRandomModel(
          meta: culinaries_random.Meta(code: 0, status: '', message: ''),
          data: culinaries_random.Data(item: []));

  bool loadingExplore = true;
  bool loadingRandom = true;

  Future<void> getDataCulinariesExplore() async {
    await CulinaryServices().getDataCulinariesExplore().then((value) {
      setState(() {
        culinariesExploreModel = value!;
      });
    });
  }

  Future<void> getDataCulinariesRandom() async {
    await CulinaryServices().getDataCulinariesRandom().then((value) {
      setState(() {
        culinariesRandomModel = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDataCulinariesRandom().whenComplete(() => loadingRandom = false);
    getDataCulinariesExplore().whenComplete(() => loadingExplore = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.whiteSecond,
      body: ListView(
        children: [
          CustomHeader(
            itemTotal: culinariesExploreModel.data.total,
            typeCategory: TypeCategory.culinary,
            favoriteTotal: culinariesExploreModel.data.favorite,
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
                    itemCount: culinariesRandomModel.data.item.length,
                    itemBuilder: (context, index) => CardMustSee(
                          image: culinariesRandomModel
                              .data.item[index].images[0].linkImage,
                          title: culinariesRandomModel.data.item[index].title,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailCulinary(
                                      id: culinariesRandomModel
                                          .data.item[index].id),
                                ));
                          },
                        )),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 18),
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
              : Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      //childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: culinariesExploreModel.data.item.length,
                    itemBuilder: (context, index) => CardCulinary(
                      alamat: culinariesExploreModel.data.item[index].address,
                      imageURL: Settings.urlBackend +
                          '/storage/' +
                          culinariesExploreModel
                              .data.item[index].images[0].linkImage,
                      name: culinariesExploreModel.data.item[index].title,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailCulinary(
                                  id: culinariesExploreModel
                                      .data.item[index].id),
                            ));
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
