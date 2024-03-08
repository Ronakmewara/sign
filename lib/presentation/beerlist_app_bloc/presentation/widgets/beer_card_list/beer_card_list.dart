

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:signup_page/router/router_constants.dart';
import 'package:sizer/sizer.dart';

class BeerCard extends StatelessWidget {
  const BeerCard({super.key, required this.list, required this.scrollController, required this.isLoading, required this.colors});
  final list;
  final ScrollController scrollController;
  final bool isLoading;
  final List colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: AlignedGridView.count(
        padding: const EdgeInsets.symmetric(vertical: 10),
        mainAxisSpacing: 3.h,
        controller: scrollController,
        itemCount: list.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == list.length) {
            return const Center(child: CircularProgressIndicator());
          } else {
            Color color = colors[index % 5];
       String stringColor = color.value.toString();


            final singleData = list[index];


            return GestureDetector(
              onTap: () {

                context.go("${RouterConstants.beerDetailsRoute}/$index/$stringColor", extra: singleData ,   );
                // Navigator.push(
                //     context,
                //     (MaterialPageRoute(
                //         builder: (context) => BeerDetailsPage(
                //             beerDetails: singleData,
                //             index: index,
                //             color: colors[index % 5]))));
              },
              child: SizedBox(
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
                ]),
              ),
            );
          }
        },
        crossAxisCount: 2,
      ),
    );
  }
}
