import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_page/common/custom_listtile_profilepage.dart';
import 'package:signup_page/presentation/signup/signup.dart';
import 'package:signup_page/theme/theme.dart';
import 'package:signup_page/presentation/updateprofile/updateprofile.dart';

import '../../model_class/user_sharedprefs.dart';
import '../login/login.dart';

String? imgPath;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
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
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 125,
                    width: 125,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    child: ClipOval(
                        child: Image.file(
                      File(imgPath!),
                      fit: BoxFit.cover,
                    )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    userData!.name ?? "",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userData!.email ?? "",
                    style: const TextStyle(fontSize: 17),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(

                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UpdateForm(data: userData ?? "", )));
                      },

                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.yellow,
                          fixedSize: const Size(220 , 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          )
                      ),
                      child: const Text(
                        'Edit Profile ',
                        style: TextStyle(fontWeight: FontWeight.bold , color: Colors.black , fontSize: 15),
                      )),

                  const SizedBox(
                    height: 25,
                  ),
                  CustomListTile(text: 'Settings', icon: Icons.settings, onPress: (){}, endIcon: true),
                  SizedBox(height: 10,),
                  CustomListTile(text: 'User Management', icon: Icons.manage_accounts, onPress: (){}, endIcon: true),
                  SizedBox(height: 10,),
                  CustomListTile(text: 'Billing Details', icon: Icons.credit_card, onPress: (){}, endIcon: true),
                  SizedBox(height: 10,),
                  CustomListTile(text: 'Information', icon: Icons.info_outline_rounded, onPress: (){}, endIcon: true),
                  SizedBox(height: 10,),
                  CustomListTile(text: 'Logout', icon: Icons.logout, onPress: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: const Text('Do You Want to Logout?'),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) => const LoginPage()),
                                        (route) => false,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                          Text('Logged Out Successfully')));
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setBool('isLogged', false);
                                },
                                child: const Text('Yes')),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No')),
                          ],
                        ));

                  }, endIcon: false),


                  const SizedBox(
                    height: 25,
                  ),



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
