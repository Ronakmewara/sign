part of 'beer_bloc.dart';

@immutable
abstract class BeerEvent {}

class FetchBeerData extends BeerEvent{
  final int currentPage;
  final String foodSearch;
  final String brewedBefore;
  final String brewedAfter;
  FetchBeerData(this.currentPage, this.foodSearch, this.brewedBefore, this.brewedAfter);
}