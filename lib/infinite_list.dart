import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:signup_page/model_class/model_beer.dart';

class InfiniteList extends StatefulWidget {
  const InfiniteList({super.key});

  @override
  State<InfiniteList> createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
  final scrollController = ScrollController();
  final _list = [];
  bool _isLoading = false;
  int currentPage = 1;
  bool isListEmpty = true;
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }


  void initState() {
    super.initState();
    scrollController.addListener(loadMore);
     fetchData(currentPage);
  }

Future<void> fetchData(int pageKey)async{
    setState(() {
      _isLoading = true;
    });
   try {
     final url = 'https://api.punkapi.com/v2/beers?page=$pageKey&per_page=10';
     final response = await http.get(Uri.parse(url));
     final data = response.body;
     final beerData = jsonDecode(data);
     if (response.statusCode == 200) {
       setState(() {
         _list.addAll(beerData as List);
         _isLoading = false;

       });
       if(_list.isNotEmpty) {
         isListEmpty = false;
       }
     } else {
       throw Exception('Failed To Load Data');
     }
   } catch(e){
     setState(() {
       _isLoading =false;
     });
   }

}

void loadMore(){
if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
  currentPage++;
  fetchData(currentPage);
}
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( ),
      body: isListEmpty ?
      const Center(child: CircularProgressIndicator(),)
      : GridView.builder(

          controller: scrollController,
          itemCount: _list.length + (_isLoading ? 1 : 0),
          itemBuilder: (context , index){

            if(index == _list.length){
              return const Center(child: CircularProgressIndicator());
            } else{
              final singleData = _list[index];
              return  Wrap(
                spacing: 10,
                direction: Axis.horizontal,
                 children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)

                      ),
                    )
                 ]
                 ,
              );

            }
          }, gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,),)


    );
  }
}
