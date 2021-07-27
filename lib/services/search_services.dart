import 'package:flutter/material.dart';
import 'package:tourpedia/models/search_culinary_model.dart';
import 'package:tourpedia/models/search_tourism_model.dart';
import 'package:tourpedia/utils/settings.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<SearchCulinaryModel?> getDataCulinariesSearch(String text) async {
    String url = Settings.urlBackend + '/api/culinaries/?search=' + text;
    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {"Accept": "aplication/json"});
      if (response.statusCode == 200) {
        debugPrint("data culinary search success");
        final culinariesExploreModel =
            searchCulinaryModelFromJson(response.body);
        return culinariesExploreModel;
      } else {
        debugPrint("error status " + response.statusCode.toString());
        return null;
      }
    } catch (e) {
      debugPrint("error catch $e");
      return null;
    }
  }

  Future<SearchTourismModel?> getDataDestinationsSearch(String text) async {
    String url = Settings.urlBackend + '/api/destinations/?search=' + text;
    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {"Accept": "aplication/json"});
      if (response.statusCode == 200) {
        debugPrint("data culinary search success");
        final destinationsSearchModel =
            searchTourismModelFromJson(response.body);
        return destinationsSearchModel;
      } else {
        debugPrint("error status " + response.statusCode.toString());
        return null;
      }
    } catch (e) {
      debugPrint("error catch $e");
      return null;
    }
  }

  Future<SearchTourismModel?> getDataDestinationsCategory(String text) async {
    String url = Settings.urlBackend + '/api/destinations/?category=' + text;
    try {
      http.Response response = await http
          .get(Uri.parse(url), headers: {"Accept": "aplication/json"});
      if (response.statusCode == 200) {
        debugPrint("data culinary search success");
        final destinationsSearchModel =
            searchTourismModelFromJson(response.body);
        return destinationsSearchModel;
      } else {
        debugPrint("error status " + response.statusCode.toString());
        return null;
      }
    } catch (e) {
      debugPrint("error catch $e");
      return null;
    }
  }
}
