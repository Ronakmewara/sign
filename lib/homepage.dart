import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:signup_page/detailspage.dart';

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
        title: Center(
          child:  Text(
            'Api Result',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white , fontSize: 25),
          ),
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
      body: ListView.builder(


        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Padding(
            padding: const EdgeInsets.all(20),
            child: ListTile(

              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DetailsPage(post: post)));
              },

              leading: CircleAvatar(
                  backgroundColor: Colors.teal,
                  maxRadius: 40,
                  child: Text(
                    post['id'].toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
              title: Text(post['title'], style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),

          );
        },
      ),
    );
  }
}
