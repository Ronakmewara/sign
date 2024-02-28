import 'dart:convert';
import 'dart:math';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';
import 'package:month_year_picker/month_year_picker.dart';

import '../../presentation/beerlist_app_bloc/data/model/beer_model/model_beer.dart';
import '../../presentation/beerlist_app_bloc/presentation/widgets/beer_card_list/beer_card_list.dart';
import '../../presentation/beerlist_app_bloc/presentation/widgets/beer_filter_bottomsheet/infinite_list_filter_dialog.dart';


class InfiniteListWithoutBloc extends StatefulWidget {
  const InfiniteListWithoutBloc({super.key});

  @override
  State<InfiniteListWithoutBloc> createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteListWithoutBloc> {
  List<Color> colors = [
    Colors.amber,
    Colors.yellow,
    Colors.green,
    Colors.lightBlue,
    Colors.lightBlueAccent,
  ];
  final scrollController = ScrollController();
  final _list = [];
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
    fetchData(currentPage);
  }

  Future<void> fetchData(int pageKey) async {
    setState(() {
      _isLoading = true;
      if (pageKey == 1) {
        _list.clear();
      }
    });
    try {
      String url = 'https://api.punkapi.com/v2/beers?page=$pageKey&per_page=10';

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
      final data = response.body;
      final List beerData = jsonDecode(data);
      List<Beer> allData = beerData.map((e) => Beer.fromJson(e)).toList();
      if (response.statusCode == 200) {
        if (_list.isNotEmpty) {
          isListEmpty = false;
        }
        setState(() {
          _list.addAll(allData);
          _isLoading = false;

        });

      } else {
        throw Exception('Failed To Load Data');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void loadMore() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      currentPage++;
      fetchData(currentPage);
    }
  }

  @override
  Widget build(BuildContext __) {
    return Scaffold(
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
                          fetchData(currentPage);
                          Navigator.pop(context);
                        },
                        onReset: () {
                          foodSearch = '';
                          brewedBefore = '';
                          brewedAfter = '';
                          Navigator.pop(context);
                          fetchData(1);
                        }, foodSearch: foodSearch, brewedBefore: brewedBefore, brewedAfter: brewedAfter,

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
        body:

        (_list.isEmpty && _isLoading)
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : _list.isEmpty  ? const Center(child: Text('No data Found'))  :  BeerCard(
          list: _list,
          scrollController: scrollController,
          isLoading: _isLoading,
          colors: colors,
        ));
  }
}