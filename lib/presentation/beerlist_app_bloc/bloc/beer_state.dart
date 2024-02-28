part of 'beer_bloc.dart';

@immutable
abstract class BeerState {}

class BeerInitial extends BeerState {}



class BeerSuccessState extends BeerState{
  final List<Beer> list;
  BeerSuccessState({ required this.list});
}

class BeerErrorState extends BeerState{
  final String errorMsg;

  BeerErrorState({required this.errorMsg});


}
class BeerLoadingState extends BeerState{
final bool firstPage;
  BeerLoadingState({required this.firstPage});

}
