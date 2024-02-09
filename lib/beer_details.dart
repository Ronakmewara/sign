import 'package:flutter/material.dart';
import 'package:signup_page/model_class/model_beer.dart';
class BeerDetailsPage extends StatelessWidget {
  const BeerDetailsPage({super.key , required this.beerDetails ,  required this.index});
  final Beer  beerDetails;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(
          tag: 'imageHero$index',
          child: Image.network(beerDetails.imageUrl??""),
        ),
      ),
    ) ;
  }
}
