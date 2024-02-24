import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import '../data/model/beer_model/model_beer.dart';
part 'beer_event.dart';
part 'beer_state.dart';

class BeerBloc extends Bloc<BeerEvent, BeerState> {
  BeerBloc() : super(BeerInitial()) {
on<FetchBeerData>(fetchBeerData);
  }
  FutureOr<void> fetchBeerData(FetchBeerData event, Emitter<BeerState> emit) async{


    if(event.currentPage == 1) {
      event.list.clear();
    }
      try {
        emit(BeerLoadingState());
        String url = 'https://api.punkapi.com/v2/beers?page=${event.currentPage}&per_page=10';
        if (event.foodSearch.isNotEmpty) {
          url += '&food=${event.foodSearch}';
        }
        if (event.brewedAfter.isNotEmpty) {
          url += '&brewed_after=${event.brewedAfter}';
        }
        if (event.brewedBefore.isNotEmpty) {
          url += '&brewed_before=${event.brewedBefore}';
        }
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = response.body;
          final List beerData = jsonDecode(data);
          List<Beer> allData = beerData.map((e) => Beer.fromJson(e)).toList();


          event.list.addAll(allData);
          print(event.list);

          emit(BeerSuccessState(list: event.list));

        } else {
        emit(BeerErrorState(errorMsg: 'some Error Occurred'));

        }
      } catch (e) {
       print(e.toString());
       emit(BeerErrorState(errorMsg: 'some Error Occurred'));
      }
    }
  }
 
