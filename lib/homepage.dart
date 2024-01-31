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
     backgroundColor: const Color.fromRGBO(216, 222, 216, 1.0),
      body: ListView.builder(


        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(

              decoration:  BoxDecoration(

                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                 BoxShadow(
                  color: Colors.black,
                offset: Offset(1, 1),
                   blurRadius: 2
              ),



                  ]

              ),

              child: Padding(
                padding: const EdgeInsets.all(10),
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
                  title: Text(post['title'], style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 17),),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),

          );
        },
      ),
    );
  }
}
