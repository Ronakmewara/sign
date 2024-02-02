import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_page/login.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  void clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(context: context, builder:(BuildContext context) => AlertDialog(

                content: const Text('Do You Want to Logout?'),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logged Out Successfully')));
                  }, child:const Text('Yes')),
                  TextButton(onPressed: (){
                            Navigator.pop(context);
                  }, child:const Text('No')),

                ],
              )
              );

            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(context: context, builder:(BuildContext context) => AlertDialog(

                content: const Text('Do You Want to Delete Your Account?'),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                            clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account Deleted ! Please Sign up to Continue')));


                  }, child:const Text('Yes')),
                  TextButton(onPressed: (){
                    Navigator.pop(context);

                  }, child:const Text('No')),

                ],
              ) );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete Account',
                style: TextStyle(color: Colors.white)),
          ),
        ],
      )),
    );
  }
}
