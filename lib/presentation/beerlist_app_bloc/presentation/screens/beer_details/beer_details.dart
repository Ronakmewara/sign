import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:signup_page/router/router_constants.dart';
import 'package:signup_page/theme/theme.dart';
import 'package:sizer/sizer.dart';

import '../../../data/model/beer_model/model_beer.dart';

class BeerDetailsPage extends StatefulWidget {
  const BeerDetailsPage(
      {super.key,
      required this.beerDetails,
      required this.index, required this.color,
      });
  final Beer beerDetails;
  final String index;
  final String color;

  @override
  State<BeerDetailsPage> createState() => _BeerDetailsPageState();
}

class _BeerDetailsPageState extends State<BeerDetailsPage> {


 Color? newColor;
  bool isFavourite = false;
  List<Beer>? favBeerList;
  List<dynamic>? BeerList;
  @override
  void initState() {

    int intColor = int.parse(widget.color);
    newColor = Color(intColor);
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
     favBeerList = favBeerListJson.map((e){
         return Beer.fromJson(e);
       }).toList();
       for (var element in favBeerList!) {
         if(element.id == widget.beerDetails.id && !element.isFav){
           setState(() {
             isFavourite= true;
           });

         }

       }
     }
      print(box.get('favBeer'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: newColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: (){
              context.go(RouterConstants.beerListWithoutBlocRoute);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: IconButton(
                icon: Icon(
                    isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color:
                    isFavourite ? Colors.red : Colors.black),


                onPressed: () async {
                  setState(() {
                    isFavourite = !isFavourite;
                  });
                  var box = await Hive.openBox('List');
                  String? favBeer = await box.get('favBeer');
                 BeerList = favBeer != null ? json.decode(favBeer) : [];


                  if (isFavourite) {
                    BeerList?.add(widget.beerDetails.toJson());
                    await box.put('favBeer', json.encode(BeerList));
                  }else{
                      BeerList?.removeWhere((element) => element['id'] == widget.beerDetails.id);
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
          backgroundColor:newColor
        ),
        body: Container(
          height: 100.h,
          width: double.infinity,
          color:  newColor,
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
                  tag: 'imageHero${int.parse(widget.index)}',
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
