import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tourpedia/models/favorite_model.dart';
import 'package:tourpedia/models/my_list_favorite_model.dart';
import 'package:tourpedia/models/my_list_favorite_tourism_model.dart';
import 'package:tourpedia/utils/settings.dart';

class FavoriteServices {
  Future<bool?> sendFavoriteCulinary(
      {required int id, required String token}) async {
    String url =
        Settings.urlBackend + '/api/user/culinaries/favorite/' + id.toString();
    try {
      http.Response response = await http.post(Uri.parse(url), headers: {
        "Accept": "aplication/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        debugPrint("data favorite success");
        final favoriteModel = favoriteModelFromJson(response.body);
        return favoriteModel.data;
      } else {
        debugPrint("error status " + response.statusCode.toString());
        return null;
      }
    } catch (e) {
      debugPrint("error catch $e");
      return null;
    }
  }

  Future<bool?> checkFavoriteCulinary(
      {required int id, required String token}) async {
    String url = Settings.urlBackend +
        '/api/user/culinaries/check-favorite/' +
        id.toString();
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Accept": "aplication/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        debugPrint("data favorite success");
        final favoriteModel = favoriteModelFromJson(response.body);
        return favoriteModel.data;
      } else {
        debugPrint("error status " + response.statusCode.toString());
        return null;
      }
    } catch (e) {
      debugPrint("error catch $e");
      return null;
    }
  }

  Future<bool?> sendFavoriteDestination(
      {required int id, required String token}) async {
    String url = Settings.urlBackend +
        '/api/user/destinations/favorite/' +
        id.toString();
    try {
      http.Response response = await http.post(Uri.parse(url), headers: {
        "Accept": "aplication/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        debugPrint("data favorite success");
        final favoriteModel = favoriteModelFromJson(response.body);
        return favoriteModel.data;
      } else {
        debugPrint("error status " + response.statusCode.toString());
        return null;
      }
    } catch (e) {
      debugPrint("error catch $e");
      return null;
    }
  }

  Future<bool?> checkFavoriteDestination(
      {required int id, required String token}) async {
    String url = Settings.urlBackend +
        '/api/user/destinations/check-favorite/' +
        id.toString();
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Accept": "aplication/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        debugPrint("data favorite success");
        final favoriteModel = favoriteModelFromJson(response.body);
        return favoriteModel.data;
      } else {
        debugPrint("error status " + response.statusCode.toString());
        return null;
      }
    } catch (e) {
      debugPrint("error catch $e");
      return null;
    }
  }

  Future<MyListFavoriteModel?> getMyListFavoriteCulinary(
      {required String token}) async {
    String url = Settings.urlBackend + '/api/user/culinaries/my-favorites/';
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Accept": "aplication/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        debugPrint("data favorite success");
        final favoriteModel = myListFavoriteModelFromJson(response.body);
        return favoriteModel;
      } else {
        debugPrint("error status " + response.statusCode.toString());
        return null;
      }
    } catch (e) {
      debugPrint("error catch $e");
      return null;
    }
  }

  Future<MyListFavoriteTourismModel?> getMyListFavoriteTourism(
      {required String token}) async {
    String url = Settings.urlBackend + '/api/user/destinations/my-favorites/';
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        "Accept": "aplication/json",
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        debugPrint("data favorite success");
        final favoriteModel = myListFavoriteTourismModelFromJson(response.body);
        return favoriteModel;
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
