import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_page/theme.dart';
import 'package:signup_page/updateprofile.dart';

String? imgPath;

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
    getProfileImage();
  }

  Future<String> getProfileImage() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    setState(() {
      imgPath = shared.getString('image');
    });
    return imgPath!;
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
        body: FutureBuilder(
      future: getProfileImage(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    child: ClipOval(
                      child:Image.file(File(imgPath!),
                         fit: BoxFit.cover,
                    ) ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: [
                      const Text(
                        'Full Name',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        data?['fullName'] ?? "",
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: [
                      const Text(
                        'Email Id',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        data?['email'] ?? "",
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: [
                      const Text(
                        'Phone Number',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                      Text(
                        data?['mobileNumber'] ?? "",
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateForm(data: data)));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.white),
                      child: const Icon(Icons.edit))
                ],
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      },
    ));
  }
}
