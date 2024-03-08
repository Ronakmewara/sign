import 'package:flutter/material.dart';


class DataService {
  List<String> fetchData() {
    return ["Item 1", "Item 2", "Item 3"];
  }
}


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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    DataService dataService = DataService();
    ListPrinter listPrinter = ListPrinter();

    listPrinter.dataService = dataService;

    return MaterialApp(
      title: 'List Printing Demo',
      home: listPrinter,
    );
  }
}
