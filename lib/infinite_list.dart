import 'dart:convert';
import 'dart:math';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:signup_page/beer_details.dart';
import 'package:signup_page/model_class/model_beer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';
import 'generated/json/base/json_convert_content.dart';

class InfiniteList extends StatefulWidget {
  const InfiniteList({super.key});

  @override
  State<InfiniteList> createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
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
    });
    try {
      final url = 'https://api.punkapi.com/v2/beers?page=$pageKey&per_page=10';
      final response = await http.get(Uri.parse(url));
      final data = response.body;
      final List beerData = jsonDecode(data);
      List<Beer> allData = beerData.map((e) => Beer.fromJson(e)).toList();
      if (response.statusCode == 200) {
        setState(() {
          _list.addAll(allData);
          _isLoading = false;
        });
        if (_list.isNotEmpty) {
          isListEmpty = false;
        }
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: isListEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: AlignedGridView.count(
                  mainAxisSpacing:3.h,
                  controller: scrollController,
                  itemCount: _list.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _list.length) {
                      return Center(child: const CircularProgressIndicator());
                    } else {
                      final singleData = _list[index];

                      return Container(
                        height: 40.h,

                        child: Stack(children: [Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              clipBehavior: Clip.none,
                              margin: const EdgeInsets.all(8.0),
                              height: 30.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(45),
                                  color: colors[index % 5],
                                  boxShadow: [
                                    BoxShadow(
                                      color: colors[index % 5].withOpacity(0.5),
                                      blurRadius: 7,
                                      spreadRadius: 5,
                                      offset: const Offset(
                                        1.0,
                                        3,
                                      ),
                                    )
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      singleData.name,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text("${singleData.ibu} IBU",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,



                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    (MaterialPageRoute(
                                        builder: (context) => BeerDetailsPage(
                                            beerDetails: singleData,
                                            index: index,
                                            color: colors[index % 5]))));
                              },
                              child: Hero(
                                tag: 'imageHero$index',
                                child: CachedNetworkImage(
                                  imageUrl: singleData.imageUrl,
                                  height: 27.h,
                                  placeholder: (context, url) => const Center(
                                    child: SizedBox(
                                      width: 40.0,
                                      height: 40.0,
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      );
                    }
                  },
                  crossAxisCount: 2,
                ),
              ));
  }
}
