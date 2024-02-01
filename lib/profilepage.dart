import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_page/theme.dart';
import 'package:signup_page/updateprofile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences prefs;
  Map<String, dynamic>? data = {};

  @override
  void initState() {
    super.initState();
    initializePreferences();
  }

  Future initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      Map<String, dynamic> userData = json.decode(userJson);

      setState(() {
        data = userData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                maxRadius: 100,
                backgroundColor: Colors.black,
                backgroundImage: AssetImage('asset/image/userImage.jpg'),
              ),
              const SizedBox(height: 25,),
              Column(
                children: [
                  const Text('Full Name', style: TextStyle(color: Colors.grey, fontSize: 12),),
                  Text(data?['fullName'] ?? "", style: const TextStyle(fontSize: 20),)
                ],
              ),
              const SizedBox(height: 25,),
              Column(
                children: [
                  const Text('Email Id', style: TextStyle(color: Colors.grey, fontSize: 12),),
                  Text(data?['email'] ?? "", style: const TextStyle(fontSize: 20),)
                ],
              ),
              const SizedBox(height: 25,),
              Column(
                children: [
                  const Text('Phone Number', style: TextStyle(color: Colors.grey, fontSize: 12),),
                  Text(data?['mobileNumber'] ?? "", style: const TextStyle(fontSize: 20),)
                ],
              ),
              const SizedBox(height: 25,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  UpdateForm(data: data)));
              },
                  style: ElevatedButton.styleFrom(backgroundColor: primaryColor , foregroundColor: Colors.white),
                  child: const Icon(Icons.edit))
            ],
          ),
        ),
      ),
    );
  }
}
