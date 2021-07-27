import 'package:flutter/material.dart';
import 'package:tourpedia/models/search_culinary_model.dart';
import 'package:tourpedia/services/search_services.dart';
import 'package:tourpedia/ui/pages/detail_culinary.dart';
import 'package:tourpedia/ui/widgets/card_culinary.dart';
import 'package:tourpedia/utils/my_colors.dart';
import 'package:tourpedia/utils/settings.dart';

class SearchCulinary extends StatefulWidget {
  const SearchCulinary({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  _SearchCulinaryState createState() => _SearchCulinaryState();
}

class _SearchCulinaryState extends State<SearchCulinary> {
  SearchCulinaryModel searchCulinaryModel = SearchCulinaryModel(
      meta: Meta(code: 0, message: '', status: ''), data: Data(data: []));

  bool loading = true;

  Future<void> getDataSearch() async {
    await SearchServices().getDataCulinariesSearch(widget.text).then((value) {
      setState(() {
        searchCulinaryModel = value!;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getDataSearch().whenComplete(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: MyColors.bluePrimary,
      ),
      body: (loading)
          ? const Center(child: CircularProgressIndicator())
          : (searchCulinaryModel.data.data.isEmpty)
              ? const Center(child: Text('Data tidak ada'))
              : Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: searchCulinaryModel.data.data.length,
                    itemBuilder: (context, index) => CardCulinary(
                      bottom: 20,
                      alamat: searchCulinaryModel.data.data[index].address,
                      imageURL: Settings.urlBackend +
                          '/storage/' +
                          searchCulinaryModel
                              .data.data[index].images[0].linkImage,
                      name: searchCulinaryModel.data.data[index].title,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailCulinary(
                                  id: searchCulinaryModel.data.data[index].id),
                            ));
                      },
                    ),
                  ),
                ),
    );
  }
}
