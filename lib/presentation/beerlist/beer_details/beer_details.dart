import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:signup_page/model_class/model_beer.dart';
import 'package:signup_page/theme/theme.dart';
import 'package:sizer/sizer.dart';
import 'package:sizer/sizer.dart';

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
          height: 100.h,
          width: double.infinity,
          color: color,
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
                        beerDetails.tagLine!,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
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
                              child: Text('${beerDetails.ph}' " " "PH",
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
                                          '${beerDetails.volume!.value.toString()} ml',
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
                                      Text('${beerDetails.ibu} IBU',
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
                                  Text('${beerDetails.firstBrewed}',
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
                                  Text('${beerDetails.ph} PH',
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
                              beerDetails.description!,
                              style:   TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold , fontSize: 10.sp),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          ElevatedButton(

                              onPressed: () {},
                            style:
                            ElevatedButton.styleFrom(
                              backgroundColor: Color.fromRGBO(15, 19, 26, 1),
                              fixedSize: Size(350 , 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)
                              )

                             ), child: const Text('Add to cart', style: TextStyle(color: Colors.white),)


                          )
                        ]),
                  ),
                ),
              ),
              // color: Color.fromRGBO(15, 19, 26, 1),

              Positioned(
                top: 4.h,
                right: 30,
                child: Hero(
                  tag: 'imageHero$index',
                  child: CachedNetworkImage(
                    imageUrl: beerDetails.imageUrl ?? "",
                    height: 55.h,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
