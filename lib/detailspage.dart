import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
   const DetailsPage({super.key , required this.post});
     final dynamic post;
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title:  Text('Details', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white , fontSize: 25),),
         backgroundColor: Colors.teal,
       ),
       body:  Padding(
         padding: const EdgeInsets.all(20),
         child: Column(

           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Padding(
               padding: const EdgeInsets.only(bottom: 60),
               child: Text(post['title'].toString() , style: Theme.of(context).textTheme.titleLarge,),
             ),

             Text(post['body'] , style: const TextStyle(fontSize: 20),)
           ],
         ),
       ) ,
     );
   }
 }
