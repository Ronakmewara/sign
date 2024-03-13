import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class Person extends Equatable{
  final String name;
  final int age;

  Person(this.name, this.age);

  @override
  // TODO: implement props
  List<Object?> get props => [name , age];
}


class EquatableDemo extends StatelessWidget {
  const EquatableDemo({super.key});


  @override
  Widget build(BuildContext context) {
    final person1 = Person('ronak', 30);
    final person2 = Person('ronak', 30);

    bool areEqual = person1 == person2;

    return Scaffold(
      appBar: AppBar(
        title: const Text('EquatableDemo'),
      ),
      body: Center(
        child: Text(
          'Are persons equal? $areEqual',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
