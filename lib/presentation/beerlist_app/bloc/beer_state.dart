part of 'beer_bloc.dart';

@immutable
abstract class BeerState {}

class BeerInitial extends BeerState {}

class ListState extends BeerState{
  final bool isListEmpty;
   ListState({required this.isListEmpty});
}

class FetchBeerDataSuccess extends BeerState{
  final List<Beer> list;
  FetchBeerDataSuccess({ required this.list});
}

class ListLoadingState extends BeerState{

}
