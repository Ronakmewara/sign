import 'package:flutter/material.dart';

import 'DataService.dart';



class PrintList extends StatelessWidget {
 final DataService dataService;
  const PrintList({super.key, required this.dataService});

  @override
  Widget build(BuildContext context) {
     List<String> items = dataService.fetchData();
   return Scaffold(
      appBar: AppBar(
        title: const Text('List Printing Example'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
      ),
    );
  }
}
