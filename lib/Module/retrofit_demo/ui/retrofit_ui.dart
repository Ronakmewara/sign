import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../api_helper/api_helper.dart';

class RetrofitDemo extends StatefulWidget {
  const RetrofitDemo({super.key});

  @override
  State<RetrofitDemo> createState() => _RetrofitDemoState();
}

class _RetrofitDemoState extends State<RetrofitDemo> {
 late List<PostModel> postList = [];

final client = RestClient(Dio(BaseOptions(contentType: "application/json")));

 void fetchPosts()async{
   var response =  await client.getPosts();

 }

 @override
  void initState() {
  fetchPosts();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Retrofit demo'),

        ),
        body: ListView.builder(itemCount: postList.length , itemBuilder: (context, index){
    return Container();
    }),);
  }
}
