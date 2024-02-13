import 'dart:convert';
import 'dart:math';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:signup_page/beer_details.dart';
import 'package:signup_page/model_class/model_beer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';
import 'package:month_year_picker/month_year_picker.dart';

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
      if (pageKey == 1) {
        _list.clear();
      }
    });
    try {
      String url = 'https://api.punkapi.com/v2/beers?page=$pageKey&per_page=10';

      if (searchByFoodController.text.isNotEmpty) {
        url += '&food=${searchByFoodController.text}';
      }
      if (brewedAfterController.text.isNotEmpty) {
        url += '&brewed_after=${brewedAfterController.text}';
      }
      if (brewedBeforeController.text.isNotEmpty) {
        url += '&brewed_before=${brewedBeforeController.text}';
      }

      final response = await http.get(Uri.parse(url));
      final data = response.body;
      final List beerData = jsonDecode(data);
      List<Beer> allData = beerData.map((e) => Beer.fromJson(e)).toList();
      if (response.statusCode == 200) {
        setState(() {
          if (searchByFoodController.text.isNotEmpty ||
              brewedBeforeController.text.isNotEmpty ||
              brewedAfterController.text.isNotEmpty) {
            _list.clear();
            _list.addAll(allData);
          } else {
            _list.addAll(allData);
          }
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

  DateTime? brewedBefore;
  DateTime? brewedAfter;
  final TextEditingController brewedBeforeController = TextEditingController();
  final TextEditingController brewedAfterController = TextEditingController();
  final TextEditingController searchByFoodController = TextEditingController();

  @override
  Widget build(BuildContext __) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Center(
                                    child: Text(
                                  'Select filters',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Brewed Before',
                                    suffix: const Align(
                                        heightFactor: 1.0,
                                        widthFactor: 1.0,
                                        child: Icon(Icons.date_range)),
                                  ),
                                  controller: brewedBeforeController,
                                  readOnly: true,
                                  onTap: () async {
                                    brewedBefore = await showMonthYearPicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1995),
                                      lastDate: DateTime(2025),
                                    );
                                    if (brewedBefore != null) {
                                      setState(() {
                                        String formattedDate =
                                            DateFormat('MM-yyyy')
                                                .format(brewedBefore!);
                                        brewedBeforeController.text =
                                            formattedDate;
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'Brewed After',
                                    suffix: const Align(
                                        heightFactor: 1.0,
                                        widthFactor: 1.0,
                                        child: Icon(Icons.date_range)),
                                  ),
                                  controller: brewedAfterController,
                                  readOnly: true,
                                  onTap: () async {
                                    brewedAfter = await showMonthYearPicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1995),
                                      lastDate: DateTime(2025),
                                    );
                                    if (brewedAfter != null) {
                                      setState(() {
                                        String formattedDate =
                                            DateFormat('MM-yyyy')
                                                .format(brewedAfter!);
                                        brewedAfterController.text =
                                            formattedDate;
                                      });
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide:
                                          const BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelText: 'filter By Food..',
                                  ),
                                  controller: searchByFoodController,
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          searchByFoodController.clear();
                                          brewedBeforeController.clear();
                                          brewedAfterController.clear();
                                          Navigator.pop(context);
                                          fetchData(1);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7))),
                                        child: const Text('Reset',style: TextStyle(
                                            color: Colors.white,
                                            fontWeight:
                                            FontWeight.bold),)),
                                    Row(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () {
                                              currentPage = 1;
                                              fetchData(currentPage);
                                              Navigator.pop(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.blue,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7))),
                                            child: const Text('OK',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.redAccent,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7))),
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ));
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
        body: isListEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                child: AlignedGridView.count(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  mainAxisSpacing: 3.h,
                  controller: scrollController,
                  itemCount: _list.length + (_isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _list.length) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      final singleData = _list[index];

                      return Container(
                        height: 40.h,
                        child: Stack(children: [
                          Positioned(
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
                                    Text(singleData.firstBrewed)
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
