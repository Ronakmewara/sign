import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../generated/freezed_demo.dart';

class UserListWithFreezed extends StatefulWidget {
  const UserListWithFreezed({super.key});

  @override
  State<UserListWithFreezed> createState() => _UserListWithFreezedState();
}

class _UserListWithFreezedState extends State<UserListWithFreezed> {
  late List<UserList> userList = [];

  @override
  void initState() {
    userList..add(const UserList(firstName: 'Ronak',
        lastName: 'Mewara',
        email: 'r@gmail.com',
        isActive: false))..add(const UserList(firstName: 'Happy',
        lastName: "Mewara",
        email: 'r@gmail.com',
        isActive: false));
    super.initState();
  }

 void _updateActiveUser( int index){

  setState(() {
    userList[index] = userList[index].copyWith( isActive: !userList[index].isActive);
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Freezed demo' , style: TextStyle(fontSize: 25),),
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder( itemCount: userList.length , itemBuilder: (context , index){
           var singleUser = userList[index];
              return Container(
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          
              ) ,
              child: ListTile(
                title: Text("${singleUser.firstName} ${singleUser.lastName}") ,
                subtitle: Text(singleUser.email),
                trailing: Transform.scale(
                    scale: 1,
                    child: Switch(
                      onChanged: (val) {
                        _updateActiveUser(index);
                      },
                      value: singleUser.isActive,
                      activeColor: Colors.blue,
                      activeTrackColor: Colors.grey.shade700,
                      inactiveThumbColor: Colors.black,
                      inactiveTrackColor: Colors.white12,
                    )),
              ),
              );
          }),
        )
      ],),
    );
  }
}
