import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:signup_page/curved_list.dart';
import 'package:signup_page/homepage.dart';
import 'package:signup_page/infinite_list.dart';

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
        'color': Colors.pinkAccent,
        'nextColor': Colors.green,
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Homepage()));
        }
      },
      {
        'title': 'Beer Listing App',
        'time': '10 Feb 2024',
        'icon': Icons.water_drop_outlined,
        'color': Colors.green,
        'nextColor': Colors.transparent,
        'onTap': () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const InfiniteList()));
        }
      },
    ];
    return Scaffold(
        body: ListView(children:
      mainPageList.map((app) => CurvedListItem(
            title: app['title'],
            time: app['time'],
            icon: app['icon'],
            color: app['color'],
            nextColor: app['nextColor'],
            onTap: app['onTap'],
          )).toList()
    )

        // ListView(
        //   children: [
        //     CurvedListItem(title: 'API Listing App', time: '5 Feb 2024', icon: Icons.list_alt, color: Colors.pinkAccent , nextColor: Colors.green,),
        //     CurvedListItem(title: 'API Listing App', time: '', icon: Icons.list_alt, color: Colors. green ,),
        //   ],
        // )
        );
  }
}
