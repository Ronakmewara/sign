import 'dart:convert';
import 'package:signup_page/model_class/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:signup_page/detailspage.dart';
import 'package:signup_page/theme.dart';
import 'package:hive/hive.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  bool isTimeMatched = false;
  late DateTime currentDate = DateTime.now();

  late DateTime expireDate;
  bool hasData = false;
  late List<Post> posts;
  late List<Post> filteredPosts = [];

  Future<List<Post>> fetchData() async {
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
      var lastDateTime = DateTime.parse(lastApicallDate.toString()).add(Duration(minutes: 5));
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
              child: ListView.builder(
                itemCount: filteredPosts.length,
                itemBuilder: (context, index) {
                  final post = filteredPosts[index];
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(1, 1),
                                blurRadius: 2),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsPage(post: post)));
                          },
                          leading: CircleAvatar(
                              backgroundColor: buttonLightGreen,
                              maxRadius: 40,
                              child: Text(
                                post.id.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor),
                              )),
                          title: Text(
                            post.title!,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontSize: 17),
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        )
            : const Center(
          child: CircularProgressIndicator(),
        ));
  }
}

//
// static Future<List<Post>> fetchData() async {
//   final time = DateTime.now();
//
//   var box = await Hive.openBox('Ronakbox');
//   await box.put('date', time);
//
//   var dataFromHive = box.get('data') as List;
//   DateTime dateFromHive =  await box.get('date');
//   DateTime expiryTime = dateFromHive.add(Duration(seconds: 30));
//   var dateString = dateFromHive.toIso8601String();
//
//   if(dateString.isNotEmpty){
//     print('isnot empty');
//     if(dataFromHive.isNotEmpty){
//       List<Post> poistList = dataFromHive.map((e) => Post.fromJson(jsonDecode(jsonEncode(e)))).toList();
//       return  poistList;
//     }
//     if(dateFromHive.isBefore(expiryTime)){
//       List<Post> poistList = dataFromHive.map((e) => Post.fromJson(jsonDecode(jsonEncode(e)))).toList();
//       return  poistList;
//     }
//     else{
//       print('Time is Expired !');
//       const url = "https://jsonplaceholder.typicode.com/posts";
//       final uri = Uri.parse(url);
//       final response = await http.get(uri);
//       final List post = json.decode(response.body);
//       return post.map((e) => Post.fromJson(e)).toList();
//     }
//
//   } else{
//     print('is Empty');
//     const url = "https://jsonplaceholder.typicode.com/posts";
//     final uri = Uri.parse(url);
//     final response = await http.get(uri);
//     final List post = json.decode(response.body);
//     return post.map((e) => Post.fromJson(e)).toList();
//   }
//
// }
