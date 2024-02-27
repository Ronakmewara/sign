import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:signup_page/common/custom_listtile_profilepage.dart';
import 'package:signup_page/presentation/beerlist_app/data/repository/beer_repo.dart';
import 'package:signup_page/utils/exception/custom_exception.dart';

import '../data/model/beer_model/model_beer.dart';

part 'beer_event.dart';

part 'beer_state.dart';

class BeerBloc extends Bloc<BeerEvent, BeerState> {
  BeerBloc() : super(BeerInitial()) {
    on<FetchBeerData>(fetchBeerData);
  }

  FutureOr<void> fetchBeerData(
      FetchBeerData event, Emitter<BeerState> emit) async {
    if (event.currentPage == 1) {
      event.list.clear();
    }

    if (event.currentPage == 1) {
      emit(BeerLoadingState(firstPage: true));
    } else {
      emit(BeerLoadingState(firstPage: false));
    }
    try {
      List<Beer> list = await BeerRepo.fetchBeer(event.currentPage,
          event.foodSearch, event.brewedAfter, event.brewedBefore);
      event.list.addAll(list);
      emit(BeerSuccessState(list: event.list));
    } on CustomException catch (e) {
      emit(BeerErrorState(errorMsg: e.message));
    } catch (e) {
      emit(BeerErrorState(errorMsg: "some Error occurred"));
    }
  }
}
