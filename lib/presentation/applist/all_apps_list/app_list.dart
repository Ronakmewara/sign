import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:signup_page/Module/beerlist_app_without_bloc/beer_infinite_listing.dart';
import 'package:signup_page/presentation/applist/single_curved_list/curved_list.dart';
import 'package:signup_page/presentation/apidata_list/homepage/apilist_homepage.dart';

import '../../../Module/blocloginapi/ui/loginform.dart';

import '../../beerlist_app_bloc/presentation/screens/infinite_beer_listing/infinite_list.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _State();
}

class _State extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    List mainPageList = [
      {
        'title': 'API Listing App',
        'time': '5 Feb 2024',
        'icon': Icons.list_alt,
        'color': const Color.fromRGBO(60, 99, 80, 1.0),
        'nextColor': const Color.fromRGBO(79, 111, 82, 1),
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Homepage()));
        }
      },
      {
        'title': 'Beer Listing App Without Bloc',
        'time': '10 Feb 2024',
        'icon': Icons.list_alt,
        'color': const Color.fromRGBO(79, 111, 82, 1),
        'nextColor': const Color.fromRGBO(115, 144, 114, 1),
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InfiniteListWithoutBloc()));
        }
      },
      {
        'title': 'Beer Listing App With Bloc',
        'time': '28 Feb 2024',
        'icon': Icons.water_drop_outlined,
        'color': const Color.fromRGBO(115, 144, 114, 1),
        'nextColor': const Color.fromRGBO(134, 167, 137, 1),
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InfiniteList()));
        }
        },{
        'title': 'Login with API',
        'time': '25 Feb 2024',
        'icon': Icons.blur_circular_outlined,
        'color': const Color.fromRGBO(134, 167, 137, 1),
        'nextColor': Colors.transparent,
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginFormNew()));
        }
      },
    ];
    return Scaffold(
        body: ListView(
            children: mainPageList
                .map((app) => CurvedListItem(
                      title: app['title'],
                      time: app['time'],
                      icon: app['icon'],
                      color: app['color'],
                      nextColor: app['nextColor'],
                      onTap: app['onTap'],
                    ))
                .toList())


        );
  }
}
