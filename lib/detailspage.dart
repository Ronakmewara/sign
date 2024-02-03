import 'package:flutter/material.dart';
import 'package:signup_page/homepage.dart';
import 'package:signup_page/mainpagewithbar.dart';

class DetailsPage extends StatelessWidget {
   const DetailsPage({super.key , required this.post});
     final dynamic post;
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         leading: IconButton(
           icon: const Icon(Icons.arrow_back_ios_new) ,color: Colors.white,
           onPressed: (){
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const MainPage()));
           },
         ),
         title:  Text('Details', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white , fontSize: 25),),
         backgroundColor: Colors.teal,
       ),
       body:  SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(20),
           child: Column(
           
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Padding(
                 padding: const EdgeInsets.only(bottom: 60),
                 child: Text(post.title , style: Theme.of(context).textTheme.titleLarge,),
               ),
           
               Text(post.body , style: const TextStyle(fontSize: 20),)
             ],
           ),
         ),
       ) ,
     );
   }
 }
