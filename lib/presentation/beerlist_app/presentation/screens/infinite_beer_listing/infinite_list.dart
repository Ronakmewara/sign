import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:signup_page/Module/blocloginapi/bloc/login_bloc.dart';
import 'package:signup_page/presentation/beerlist_app/bloc/beer_bloc.dart';
import 'package:signup_page/presentation/beerlist_app/data/model/beer_model/model_beer.dart';
import '../../widgets/beer_card_list/beer_card_list.dart';
import '../../widgets/beer_filter_bottomsheet/infinite_list_filter_dialog.dart';

class InfiniteList extends StatefulWidget {
  const InfiniteList({super.key});

  @override
  State<InfiniteList> createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
   List<Beer> list = [];
  BeerBloc beerBloc = BeerBloc();
  List<Color> colors = [
    Colors.amber,
    Colors.yellow,
    Colors.green,
    Colors.lightBlue,
    Colors.lightBlueAccent,
  ];
  final scrollController = ScrollController();

  bool _isLoading = false;
  int currentPage = 1;
  bool isListEmpty = true;
  String foodSearch = '';
  String brewedBefore = '';
  String brewedAfter = '';

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  void initState() {
    super.initState();
    scrollController.addListener(loadMore);
     beerBloc.add(FetchBeerData(currentPage, foodSearch, brewedBefore, brewedAfter, list));
  }



  void loadMore() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      currentPage++;
      beerBloc.add(
          FetchBeerData(currentPage, foodSearch, brewedBefore, brewedAfter , list));
    }
  }

  @override
  Widget build(BuildContext __) {
    return BlocProvider(
      create: (context) => beerBloc,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'All Beers',
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      elevation: 1,
                      context: context,
                      builder: (_) {
                        return InfiniteListFilterBottomSheet(
                          onCancel: () {
                            Navigator.pop(context);
                          },
                          onSubmit: (foodSearch1, brewedBefore1, brewedAfter1) {
                            currentPage = 1;
                            this.foodSearch = foodSearch1;
                            this.brewedBefore = brewedBefore1;
                            this.brewedAfter = brewedAfter1;
                            beerBloc.add(FetchBeerData(currentPage, foodSearch,
                                brewedBefore, brewedAfter , list));
                            Navigator.pop(context);
                          },
                          onReset: () {
                            foodSearch = '';
                            brewedBefore = '';
                            brewedAfter = '';
                            Navigator.pop(context);
                            beerBloc.add(FetchBeerData(
                                1, foodSearch, brewedBefore, brewedAfter , list));
                          },
                          foodSearch: foodSearch,
                          brewedBefore: brewedBefore,
                          brewedAfter: brewedAfter,
                        );
                      });
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Row(
                    children: [
                      Text(
                        'Filters',
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.filter_alt_outlined,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          body: BlocConsumer<BeerBloc, BeerState>(
              listener: (context, state) {},
              builder: (context, state) {
             if(state is BeerErrorState){
               return Center(child:  Text(state.errorMsg));
             }
             else if (state is BeerSuccessState) {
                  return BeerCard(
                      list: state.list,
                      scrollController: scrollController,
                      isLoading: _isLoading,
                      colors: colors);
                }  else {
                 // return Center(child: const Text('no data found'));
               return Center(child: CircularProgressIndicator());
                 }
              })
          // (_list.isEmpty && _isLoading)
          //     ? const Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     : _list.isEmpty  ? const Center(child: Text('No data Found'))  :  BeerCard(
          //         list: _list,
          //         scrollController: scrollController,
          //         isLoading: _isLoading,
          //         colors: colors,
          //       )

          ),
    );
  }
}
