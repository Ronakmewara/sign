import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:signup_page/model_class/model_beer.dart';
import 'package:signup_page/theme.dart';

class BeerDetailsPage extends StatelessWidget {
  const BeerDetailsPage(
      {super.key,
      required this.beerDetails,
      required this.index,
      required this.color});

  final Beer beerDetails;
  final int index;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color,
        appBar: AppBar(
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 40),
              child: Icon(Icons.favorite_border),
            )
          ],
          title: Text(
            beerDetails.name!,
            style: const TextStyle(fontSize: 20),
          ),
          backgroundColor: color,
        ),
        body: Container(
          height: 1000,
          width: 1000,
          color: color,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width : 200,
                      child: Text(
                        beerDetails.tagLine!,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold , color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Center(
                              child: Text('${beerDetails.ph.toString()}'" " "PH",
                                  style: const TextStyle(
                                      fontSize: 25,
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
                  height: 500,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 40, top: 40, right: 40),
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
                                              fontSize: 17),
                                        ),
                                        Text(
                                          '${beerDetails.volume!.value.toString()} ml',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
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
                                            color: hintTextColor, fontSize: 17),
                                      ),
                                      Text('${beerDetails.ibu} IBU',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20))
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
                                        color: hintTextColor, fontSize: 17),
                                  ),
                                  Text('${beerDetails.firstBrewed}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))
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
                                        color: hintTextColor, fontSize: 17),
                                  ),
                                  Text('${beerDetails.ph} PH',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20))
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 100,
                            child: Text(
                              beerDetails.description!,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: Container(
                              height: 60,
                              width: 400,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black54,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromRGBO(15, 19, 26, 1),
                                        offset: Offset(1, 3))
                                  ]),
                              child: const Center(
                                child: Text(
                                  "Add to cart",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              ),
                            ),
                          )
                        ]),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                right: 30,
                child: Hero(
                  tag: 'imageHero$index',
                  child: CachedNetworkImage(
                    alignment: Alignment.topCenter,
                    imageUrl: beerDetails.imageUrl ?? "",
                    height: 500,
                    width: 200,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
