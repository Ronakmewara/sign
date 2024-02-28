import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../utils/exception/custom_exception.dart';
import '../../model/beer_model/model_beer.dart';

class FilterRepo{

  static Future<List<Beer>> fetchFilterData( String foodSearch  , String brewedBefore ,  String brewedAfter , int currentPage)async{

    List<Beer> allData = [];

    String url = 'https://api.punkapi.com/v2/beers?page=$currentPage&per_page=10';
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
    if(response.statusCode == 200){


      final data = response.body;
      final List beerData = jsonDecode(data);
      allData = beerData.map((e) => Beer.fromJson(e)).toList();

    }
    else if(response.statusCode == 404){
      throw CustomException(response.reasonPhrase.toString());
    }
    return allData;

  }

}