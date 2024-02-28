import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:signup_page/utils/exception/custom_exception.dart';

import '../data/model/beer_model/model_beer.dart';
import '../data/repository/filter_repo/filter_repo.dart';
import '../data/repository/first_time_api_repo/beer_repo.dart';

part 'beer_event.dart';

part 'beer_state.dart';

class BeerBloc extends Bloc<BeerEvent, BeerState> {
  BeerBloc() : super(BeerInitial()) {
    on<FetchBeerData>(fetchBeerData);
    on<FetchFilteredBeerData>(fetchFilteredBeerData);
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
      List<Beer> list = await BeerRepo.fetchBeer(event.currentPage);
      event.list.addAll(list);
      emit(BeerSuccessState(list: event.list));
    } on CustomException catch (e) {
      emit(BeerErrorState(errorMsg: e.message));
    } catch (e) {
      emit(BeerErrorState(errorMsg: "some Error occurred"));
    }
  }

  FutureOr<void> fetchFilteredBeerData(FetchFilteredBeerData event, Emitter<BeerState> emit) async{
    if (event.currentPage == 1) {
      event.list.clear();
    }

    if (event.currentPage == 1) {
      emit(BeerLoadingState(firstPage: true));
    } else {
      emit(BeerLoadingState(firstPage: false));
    }
    try{
      List<Beer> list = await FilterRepo.fetchFilterData( event.foodSearch, event.brewedBefore, event.brewedAfter, event.currentPage);
      event.list.addAll(list);
      emit(BeerSuccessState(list: event.list));

    } on CustomException catch (e){
      emit(BeerErrorState(errorMsg: e.message));
    } catch(e){
      emit(BeerErrorState(errorMsg: 'some Error Occurred'));
    }
  }
}
