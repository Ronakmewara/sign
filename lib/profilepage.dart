import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences prefs;
  Map<String, dynamic>? data = {};

  @override
  void initState(){
    super.initState();
    initializePreferences();
  }

  Future<void> initializePreferences()async {
    prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(
        'user');

    if (userJson != null) {
      Map<String, dynamic> userData = json
          .decode(userJson);

      setState(() {
        data = userData;
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
          body: Center(
            child: Padding(
<<<<<<< HEAD
              padding: const EdgeInsets.all( 50),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      maxRadius: 80,

                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('asset/image/userImage.jpg'),

                    ),

                    const SizedBox(height: 70,),

                    Column(
                      children: [
                        const Text('Full Name', style: TextStyle(color: Colors.grey , fontSize: 12),),
                        Text(data?['fullName'] ?? "",style: const TextStyle(fontSize: 20),)
                      ],
                    ),
                   const SizedBox(height: 25,),

                    Column(
                      children: [
                        const Text('Email Id', style: TextStyle(color: Colors.grey , fontSize: 12),),
                        Text(data?['email'] ?? "" , style: const TextStyle(fontSize: 20), )
                      ],
                    ),
                    const SizedBox(height: 25,),
                    Column(
                      children: [
                        const Text('Phone Number', style: TextStyle(color: Colors.grey , fontSize: 12),),
                        Text(data?['mobileNumber'] ?? "",style: const TextStyle(fontSize: 20),)
                      ],
                    ),
                    const SizedBox(height: 25,),

                  ],
                ),
=======
              padding: const EdgeInsets.only(top: 50),
              child: Column(

                children: [
                  const CircleAvatar(
                    maxRadius: 100,
                    backgroundColor: Colors.black,

                  ),

                  const SizedBox(height: 25,),

                  Column(
                    children: [
                      const Text('Full Name', style: TextStyle(color: Colors.grey , fontSize: 12),),
                      Text(data?['fullName'] ?? "",style: const TextStyle(fontSize: 20),)
                    ],
                  ),
                 const SizedBox(height: 25,),

                  Column(
                    children: [
                      const Text('Email Id', style: TextStyle(color: Colors.grey , fontSize: 12),),
                      Text(data?['email'] ?? "" , style: const TextStyle(fontSize: 20), )
                    ],
                  ),
                  const SizedBox(height: 25,),
                  Column(
                    children: [
                      const Text('Phone Number', style: TextStyle(color: Colors.grey , fontSize: 12),),
                      Text(data?['mobileNumber'] ?? "",style: const TextStyle(fontSize: 20),)
                    ],
                  ),
                  const SizedBox(height: 25,),

                ],
>>>>>>> origin/master
              ),
            ),
          ),
    );
  }
}
