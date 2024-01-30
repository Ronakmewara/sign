import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {
  List<dynamic> posts = [];

  Future fetchData() async {
    const url = "https://jsonplaceholder.typicode.com/posts";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final post = jsonDecode(body);
    setState(() {
      posts = post;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: false,
        title: const Text(
          'Api Result',
          style: TextStyle(color: Colors.white),
        ),
        actions:  [
       PopupMenuButton(

       child:  const IconButton(onPressed: null, icon: Icon(Icons.more_vert , color: Colors.white,), iconSize: 35,),
        itemBuilder: (context){
         return [
          const PopupMenuItem( value: 0 ,child: Text('Logout'))
         ];

        },
         onSelected: (value){
         if(value == 0){
           Navigator.pop(context);
           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
             content: Text('Logged out Successfully'),
             duration: Duration(seconds: 3),
           ));
         }
         },

       )
        ],

        backgroundColor: Colors.teal,
      ),
      body: ListView.separated(
        separatorBuilder: (context , index){
          return const Divider(
            thickness: 2,
          );
        },
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListTile(

              leading: CircleAvatar(
                  backgroundColor: Colors.teal,
                  maxRadius: 40,
                  child: Text(
                    post['id'].toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              title: Text(post['title'], style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),),
            ),

          );
        },
      ),
    );
  }
}
