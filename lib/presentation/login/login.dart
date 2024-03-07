import 'package:flutter/material.dart';
import 'package:signup_page/presentation/login/login_form/login_form.dart';
import 'package:signup_page/theme/theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            // Image.asset(
            //   'asset/image/appbackground.jpg',
            //   fit: BoxFit.cover,
            // ),
            Positioned(
              bottom: -100,
              left: -50,
              child: Transform(
                  transform: Matrix4.rotationZ(-15),
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: 0.1,
                    child: Image.asset(
                      'asset/image/leaf.png',
                    ),
                  )),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(45),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Text(
                      'Welcome\nBack',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: primaryColor,
                          ),
                      textAlign: TextAlign.left,
                    ),
                    const Center(child: LoginForm()),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
