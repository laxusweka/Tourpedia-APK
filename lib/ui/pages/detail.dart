import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'package:tourpedia/models/tourism_detail_model.dart';
import 'package:tourpedia/services/favorite_services.dart';
import 'package:tourpedia/services/tourism_services.dart';
import 'package:tourpedia/ui/widgets/card_must_see.dart';
import 'package:tourpedia/ui/widgets/image_slider.dart';
import 'package:tourpedia/ui/widgets/maps.dart';
import 'package:tourpedia/utils/my_colors.dart';
import 'package:tourpedia/utils/settings.dart';
import 'package:tourpedia/models/tourism_model_random.dart' as tourism_random;

class Detail extends StatefulWidget {
  const Detail({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  TourismDetailModel tourismDetailModel = TourismDetailModel(
      meta: Meta(code: 0, status: '', message: ''),
      data: Data(
          id: 0,
          title: '',
          description: '',
          linkMaps: '',
          images: [],
          address: '',
          category: '',
          contact: '',
          time: ''));

  bool loading = true;
  bool isFavorite = false;

  tourism_random.TourismModelRandom tourismModelRandom =
      tourism_random.TourismModelRandom(
          meta: tourism_random.Meta(code: 0, message: '', status: ''),
          data: tourism_random.Data(item: []));

  Future<void> getDataDetailTourism() async {
    await TourismServices().getDataTourismDetail(widget.id).then((value) {
      setState(() {
        tourismDetailModel = value!;
      });
    });
    _convertImages();
  }

  Future<void> getDataTourismRandom() async {
    await TourismServices().getDataTourismRandom().then((value) {
      setState(() {
        tourismModelRandom = value!;
      });
    });
  }

  Future<void> getStatusFavorite() async {
    String token = SpUtil.getString('token', defValue: '')!;
    await FavoriteServices()
        .checkFavoriteDestination(id: widget.id, token: token)
        .then((value) {
      setState(() {
        isFavorite = value!;
      });
    });
  }

  Future<void> sendFavorite() async {
    String token = SpUtil.getString('token', defValue: '')!;
    await FavoriteServices()
        .sendFavoriteDestination(id: widget.id, token: token);
  }

  @override
  void initState() {
    getDataTourismRandom();
    getStatusFavorite();
    getDataDetailTourism().whenComplete(() => loading = false);
    super.initState();
  }

  List<String> _convertImages() {
    List<String> images = [];
    for (var item in tourismDetailModel.data.images) {
      images.add(Settings.urlBackend + '/storage/' + item.linkImage);
    }
    debugPrint(images.toString());
    return images;
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Scaffold(
            backgroundColor: MyColors.whiteFour,
            body: ListView(
              children: [
                Stack(
                  children: [
                    ImageSlider(images: _convertImages()),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 15,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: MyColors.whiteFour,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TouchableOpacity(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: MyColors.white,
                              shape: BoxShape.circle,
                            ),
                            margin: const EdgeInsets.only(top: 20, left: 20),
                            padding: const EdgeInsets.all(5),
                            child: const Icon(
                              Icons.arrow_back,
                              size: 30,
                            ),
                          ),
                        ),
                        TouchableOpacity(
                          onTap: () {
                            setState(() {
                              sendFavorite();
                              isFavorite = !isFavorite;
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              // color: (isFavorite)
                              //     ? MyColors.button
                              //     : MyColors.white,
                              color: MyColors.white,
                              shape: BoxShape.circle,
                            ),
                            margin: const EdgeInsets.only(top: 20, right: 20),
                            padding: const EdgeInsets.all(5),
                            child: (isFavorite)
                                ? const Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite_border,
                                    size: 30,
                                    //color: Colors.red,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    height: 5,
                    width: 100,
                    margin: const EdgeInsets.only(bottom: 30),
                    decoration: const BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                  ),
                ),
                /**
           * NAME
           */
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    tourismDetailModel.data.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Wrap(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(1)),
                          color: MyColors.white),
                      child: Text(
                        tourismDetailModel.data.category,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),

                /**
           * ABOUT
           */
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 5),
                  decoration: const BoxDecoration(
                    color: MyColors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'Tentang',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        tourismDetailModel.data.description,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 20),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 5),
                  decoration: const BoxDecoration(
                    color: MyColors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        'Informasi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 7),
                      const Text(
                        'Jam Operasional',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        tourismDetailModel.data.time,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: MyColors.black.withOpacity(0.7)),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Kontak',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        tourismDetailModel.data.contact,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: MyColors.black.withOpacity(0.7)),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Alamat',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        tourismDetailModel.data.address,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: MyColors.black.withOpacity(0.7)),
                      ),
                    ],
                  ),
                ),
                Maps(url: tourismDetailModel.data.linkMaps),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  decoration: const BoxDecoration(color: MyColors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          'Rekomendasi Lainnya',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: tourismModelRandom.data.item.length,
                            itemBuilder: (context, index) => CardMustSee(
                                  image: tourismModelRandom
                                      .data.item[index].images[0].linkImage,
                                  title:
                                      tourismModelRandom.data.item[index].title,
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
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
