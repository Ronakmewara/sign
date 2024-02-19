import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:signup_page/model_class/model_beer.dart';
import 'package:signup_page/theme/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:sizer/sizer.dart';
import 'package:hive/hive.dart';

class BeerDetailsPage extends StatefulWidget {
  const BeerDetailsPage(
      {super.key,
      required this.beerDetails,
      required this.index,
      required this.color});

  final Beer beerDetails;
  final int index;
  final Color color;

  @override
  State<BeerDetailsPage> createState() => _BeerDetailsPageState();
}

class _BeerDetailsPageState extends State<BeerDetailsPage> {
  bool isFavourite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeList();
  }

  void initializeList() async {
    var box = await Hive.openBox('List');
    if (box.get('favBeer') == null) {
      List<Beer> favouriteBeers = [];
      await box.put('favBeer', json.encode(favouriteBeers));
    } else {
      String? favBeer = await box.get('favBeer');
     if(favBeer!=null){
       List<dynamic> favBeerListJson = json.decode(favBeer);
       List<Beer> favBeerList = favBeerListJson.map((e){
         return Beer.fromJson(e);
       }).toList();

       for (var element in favBeerList) {
         if(element.id == widget.beerDetails.id && widget.beerDetails.isFav){
           isFavourite = true;
         }

       }
     }
      print(box.get('favBeer'));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.color,
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: IconButton(
                icon: Icon(
                    widget.beerDetails.isFav
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color:
                        widget.beerDetails.isFav ? Colors.red : Colors.black),


                onPressed: () async {
                  setState(() {
                    widget.beerDetails.isFav = !widget.beerDetails.isFav;
                  });
                  var box = await Hive.openBox('List');
                  String? favBeer = await box.get('favBeer');

                  List<dynamic> BeerList =
                      favBeer != null ? json.decode(favBeer) : [];


                  if (widget.beerDetails.isFav) {
                    BeerList.add(widget.beerDetails.toJson());
                    await box.put('favBeer', json.encode(BeerList));
                  }
                },


              ),
            )
          ],
          title: Text(
            widget.beerDetails.name!,
            style: const TextStyle(fontSize: 20),
          ),
          backgroundColor: widget.color,
        ),
        body: Container(
          height: 100.h,
          width: double.infinity,
          color: widget.color,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      child: Text(
                        widget.beerDetails.tagLine!,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5.sp),
                          child: Center(
                              child: Text('${widget.beerDetails.ph}' " " "PH",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold))),
                        ))
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  clipBehavior: Clip.none,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 40, 40, 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Vol.",
                                          style: TextStyle(
                                              color: hintTextColor,
                                              fontSize: 12.sp),
                                        ),
                                        Text(
                                          '${widget.beerDetails.volume!.value.toString()} ml',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp),
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Alc.",
                                        style: TextStyle(
                                            color: hintTextColor,
                                            fontSize: 12.sp),
                                      ),
                                      Text('${widget.beerDetails.ibu} IBU',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp))
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "First Brewed",
                                    style: TextStyle(
                                        color: hintTextColor, fontSize: 12.sp),
                                  ),
                                  Text('${widget.beerDetails.firstBrewed}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp))
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "PH",
                                    style: TextStyle(
                                        color: hintTextColor, fontSize: 12.sp),
                                  ),
                                  Text('${widget.beerDetails.ph} PH',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14.sp))
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 12.h,
                            child: Text(
                              widget.beerDetails.description!,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.sp),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromRGBO(15, 19, 26, 1),
                                  fixedSize: Size(350, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7))),
                              child: const Text(
                                'Add to cart',
                                style: TextStyle(color: Colors.white),
                              ))
                        ]),
                  ),
                ),
              ),
              // color: Color.fromRGBO(15, 19, 26, 1),

              Positioned(
                top: 4.h,
                right: 30,
                child: Hero(
                  tag: 'imageHero${widget.index}',
                  child: CachedNetworkImage(
                    imageUrl: widget.beerDetails.imageUrl ?? "",
                    height: 55.h,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void saveToHive() async {
    final box = await Hive.openBox('favBeer');
  }
}
