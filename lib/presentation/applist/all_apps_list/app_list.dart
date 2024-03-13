import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:signup_page/presentation/applist/single_curved_list/curved_list.dart';
import 'package:signup_page/router/router_constants.dart';

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
           context.go(RouterConstants.apiDataList);
        }
      },
      {
        'title': 'Beer Listing App Without Bloc',
        'time': '10 Feb 2024',
        'icon': Icons.list_alt,
        'color': const Color.fromRGBO(79, 111, 82, 1),
        'nextColor': const Color.fromRGBO(115, 144, 114, 1),
        'onTap': () {
           context.go(RouterConstants.beerListWithoutBlocRoute);
        }
      },
      {
        'title': 'Beer Listing App With Bloc',
        'time': '28 Feb 2024',
        'icon': Icons.water_drop_outlined,
        'color': const Color.fromRGBO(115, 144, 114, 1),
        'nextColor': const Color.fromRGBO(134, 167, 137, 1),
        'onTap': () {
          context.go(RouterConstants.beerListWithBlocRoute);
        }
        },{
        'title': 'Login with API',
        'time': '25 Feb 2024',
        'icon': Icons.blur_circular_outlined,
        'color': const Color.fromRGBO(134, 167, 137, 1),
        'nextColor': Colors.transparent,
        'onTap': () {
          context.go(RouterConstants.apiLoginWithBloc);
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
