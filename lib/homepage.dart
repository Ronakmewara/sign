import 'dart:convert';
import 'package:signup_page/model_class/post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:signup_page/detailspage.dart';
import 'package:signup_page/theme.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => HomepageState();
}

class HomepageState extends State<Homepage> {


 static Future<List<Post>> fetchData() async {
    const url = "https://jsonplaceholder.typicode.com/posts";
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final List post = json.decode(response.body);

     return post.map((e) => Post.fromJson(e)).toList();
  }

  final TextEditingController searchController = TextEditingController();
   late List<Post> posts;
   late List<Post> filteredPosts;
  @override
  void initState() {
    super.initState();

      fetchData().then((data){
        setState(() {
          posts = data;
          filteredPosts = data;
        });
      });
  }

  void onSearchTextChanged(String searchText){
    filteredPosts = posts.where((post) => post.title!.toLowerCase().contains(searchText.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: buttonLightGreen,

      body: Center(



        child: Column(
          children: [
            TextField(
              controller: searchController ,
              onChanged: onSearchTextChanged,
              decoration: const InputDecoration(
                hintText: 'Search...',
                prefixIcon: const Icon(Icons.search)

              ),
            ),

            Expanded(
              child: FutureBuilder(
                future: fetchData(),
                 builder: (context , snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    if(snapshot.hasError){
                                  return const Center(
                                    child: Text('No data Found'),
                                  );
                    } else if(snapshot.hasData){
                      return ListView.builder(
              
              
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
                                        blurRadius: 2
                                    ),
                                  ]
              
                              ),
              
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ListTile(
              
              
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
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
                                  title: Text(post.title!, style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(fontSize: 17),),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                            ),
              
                          );
                        },
                      );
                    }
              
                  }
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
              
                 },
                  ),
            ),
          ],
        ),
      )


    );
    }
  }
