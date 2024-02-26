import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/beer_model/model_beer.dart';

class BeerRepo {
  static Future<List<Beer>> fetchBeer(int currentPage, String foodSearch,
      String brewedAfter, String brewedBefore, List<Beer> list) async {
    try {
      String url =
          'https://api.punkapi.com/v2/beers?page=$currentPage&per_page=10';
      if (foodSearch.isNotEmpty) {
        url += '&food=$foodSearch';
      }
      if (brewedAfter.isNotEmpty) {
        url += '&brewed_after=$brewedAfter';
      }
      if (brewedBefore.isNotEmpty) {
        url += '&brewed_before=$brewedBefore';
      }
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = response.body;
        final List beerData = jsonDecode(data);
        List<Beer> allData = beerData.map((e) => Beer.fromJson(e)).toList();
        list.addAll(allData);
      }

    }
    catch (e) {
      print(e.toString());
    }
    return list;
  }

}
