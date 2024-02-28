part of 'beer_bloc.dart';

@immutable
abstract class BeerEvent {}

class FetchBeerData extends BeerEvent{
  final int currentPage;
  final List<Beer> list;
  FetchBeerData(this.currentPage, this.list);
}

class FetchFilteredBeerData extends BeerEvent{
  final List<Beer> list;
  final int currentPage;
  final String foodSearch;
  final String brewedBefore;
  final String brewedAfter;

  FetchFilteredBeerData(this.foodSearch, this.brewedBefore, this.brewedAfter , this.currentPage, this.list);
}
