import 'package:flutter/material.dart';


class DataService {
  List<String> fetchData() {
    return ["Item 1", "Item 2", "Item 3"];
  }
}


class ListPrinter extends StatelessWidget {
  final DataService dataService;

  ListPrinter({required this.dataService});

  @override
  Widget build(BuildContext context) {
    List<String> items = dataService.fetchData();

    return Scaffold(
      appBar: AppBar(
        title: Text('List Printing Example'),
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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Printing Demo',
      home: ListPrinter(
        dataService: DataService(),
      ),
    );
  }
}
