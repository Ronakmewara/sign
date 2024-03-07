import 'package:flutter/material.dart';

// Example dependency class
class DataService {
  List<String> fetchData() {
    return ["Item 1", "Item 2", "Item 3"];
  }
}

// Widget that uses setter injection
class ListPrinter extends StatelessWidget {
  DataService? _dataService;

  set dataService(DataService dataService) {
    _dataService = dataService;
  }

  @override
  Widget build(BuildContext context) {
    if (_dataService == null) {
      throw Exception('DataService must be set before building ListPrinter');
    }

    List<String> items = _dataService!.fetchData();

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
    DataService dataService = DataService();
    ListPrinter listPrinter = ListPrinter();

    // Setting the dependency through setter injection
    listPrinter.dataService = dataService;

    return MaterialApp(
      title: 'List Printing Demo',
      home: listPrinter,
    );
  }
}
