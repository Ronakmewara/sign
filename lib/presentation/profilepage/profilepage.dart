import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_page/theme/theme.dart';
import 'package:signup_page/presentation/updateprofile/updateprofile.dart';

import '../../model_class/user_sharedprefs.dart';

String? imgPath;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with AutomaticKeepAliveClientMixin<ProfilePage>{
  late SharedPreferences prefs;
  var userData;

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
       userData = User.fromJson(json.decode(userJson));

    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                        userData!.name ?? "" ,
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
                        userData!.email??"" ,
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
                        userData!.mobileNumber??"",
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateForm(data: userData??"")));
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

  @override

  bool get wantKeepAlive => true;
}
