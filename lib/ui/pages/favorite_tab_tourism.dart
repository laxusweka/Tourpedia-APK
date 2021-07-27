import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';
import 'package:tourpedia/models/my_list_favorite_tourism_model.dart';
import 'package:tourpedia/services/favorite_services.dart';
import 'package:tourpedia/ui/pages/detail.dart';
import 'package:tourpedia/ui/widgets/card_favorited.dart';

class FavoriteTabTourism extends StatefulWidget {
  const FavoriteTabTourism({Key? key}) : super(key: key);

  @override
  _FavoriteTabTourismState createState() => _FavoriteTabTourismState();
}

class _FavoriteTabTourismState extends State<FavoriteTabTourism> {
  MyListFavoriteTourismModel myListFavoriteModel = MyListFavoriteTourismModel(
      meta: Meta(code: 0, message: '', status: ''), data: []);

  bool loading = true;

  // ignore: unused_field
  late Future _data;

  Future<void> getDataFavoriteDestination() async {
    String token = SpUtil.getString('token', defValue: '')!;
    debugPrint('getDataFavoriteCulinary Jalan');
    await FavoriteServices()
        .getMyListFavoriteTourism(token: token)
        .then((value) {
      setState(() {
        myListFavoriteModel = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _data = getDataFavoriteDestination().whenComplete(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (loading)
          ? const Center(child: CircularProgressIndicator())
          : (myListFavoriteModel.data.isEmpty)
              ? const Center(child: Text('Data tidak ada'))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: myListFavoriteModel.data.length,
                  itemBuilder: (context, index) => CardFavorited(
                    text: myListFavoriteModel.data[index].title,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Detail(id: myListFavoriteModel.data[index].id),
                          ));
                    },
                  ),
                ),
    );
  }
}
