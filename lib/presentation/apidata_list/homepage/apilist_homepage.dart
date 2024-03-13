import 'dart:convert';
import 'dart:ffi';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:go_router/go_router.dart';
import 'package:signup_page/data/remote_config/remote_config.dart';
import 'package:signup_page/model_class/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:signup_page/theme/theme.dart';
import 'package:hive/hive.dart';

import '../../../router/router_constants.dart';
import '../apidata_list/apidata_list.dart';


class ApiDataList extends StatefulWidget {
  const ApiDataList({super.key});


  @override
  State<ApiDataList> createState() => HomepageState();
}


class HomepageState extends State<ApiDataList> {
  bool isTimeMatched = false;
  late DateTime currentDate = DateTime.now();

  late DateTime expireDate;
  bool hasData = false;
  late List<Post> posts;
  late List<Post> filteredPosts = [];

  Future<List<Post>> fetchData() async {
   var remoteConfigTime = await FirebaseRemoteConfigClass().initializeConfig();
    final box = await Hive.openBox('RonakBox');
    var lastApicallDate = box.get('date');
    if (lastApicallDate == null) {
      print("===========");
      print("First Time Api called! :: Date And Data should be saved in hive");
      print("===========");
      await box.put('date', currentDate);
       return  makeApicall();
    } else {

      var dataFromHive = await box.get('data') as List;
            print(DateTime.parse(lastApicallDate.toString()));
      if (dataFromHive.isEmpty) return [];
      var lastDateTime = DateTime.parse(lastApicallDate.toString()).add(Duration(minutes: int.parse(remoteConfigTime) ));
  // case 1 - 8:05  + 5 = 8:10
      //case 2 - 8:06 true
      if(lastDateTime.isAfter(DateTime.now())) {

        List<Post> poistList = dataFromHive
            .map((e) => Post.fromJson(jsonDecode(jsonEncode(e))))
            .toList();
        return poistList;
      }
      else {
        print('=======');
        print('date is Expired :: Expired Data should be taken from API AGAIN');
        print('=======');

        await box.put('date', currentDate);
       return makeApicall();

      }

  }  return [];
  }

  Future<List<Post>> makeApicall() async{
    const url = "https://jsonplaceholder.typicode.com/posts";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final List post = json.decode(response.body);
    saveOnHive(post.map((e) => Post.fromJson(e)).toList());
    return post.map((e) => Post.fromJson(e)).toList();
  }

  void saveOnHive(List<Post> posts) async {
    var box = await Hive.openBox("RonakBox");
    await box.put(
      'data',
      posts.map((e) => e.toJson()).toList(),
    );
  }

  final TextEditingController searchController = TextEditingController();
  @override

  void initState() {
    super.initState();

    fetchData().then((data) {
      setState(() {
        posts = data;
        filteredPosts = data;
        hasData = true;
      });
    });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: (){
                context.go(RouterConstants.appListRoute);
          },
        ),
        title: const Text('Api Data List' , style: TextStyle(fontSize: 25 ),),
        centerTitle: true,
      ),
        backgroundColor: buttonLightGreen,
        body: hasData
            ? Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (String searchText) {
                setState(() {
                  filteredPosts = posts
                      .where((post) =>
                      post.title!
                          .toLowerCase()
                          .contains(searchText.toLowerCase()))
                      .toList();
                });
              },
              decoration: const InputDecoration(
                  hintText: 'Search...', prefixIcon: Icon(Icons.search)),
            ),

            Expanded(
              child:  ListBuilder(filteredPosts: filteredPosts,)
            )
          ],
        )
            : const Center(
          child: CircularProgressIndicator(),
        ));
  }
}


