import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:signup_page/utils/exception/custom_exception.dart';
import '../../model/beer_model/model_beer.dart';

class BeerRepo {
  static Future<List<Beer>> fetchBeer(int currentPage) async {
    List<Beer> allData = [];

    String url = 'https://api.punkapi.com/v2/beers?page=$currentPage&per_page=10';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = response.body;
      final List beerData = jsonDecode(data);
      allData = beerData.map((e) => Beer.fromJson(e)).toList();
    } else if (response.statusCode == 404) {
      throw CustomException(response.reasonPhrase.toString());
    }
    return allData;
  }
}