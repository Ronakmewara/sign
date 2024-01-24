import 'package:flutter/material.dart';
import 'package:signup_page/login.dart';
import 'package:signup_page/theme.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Image.asset(
            'asset/image/appbackground.jpg',
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 200,
                ),
                Text(
                  'Create\nAccount',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: primaryColor,
                      ),
                  textAlign: TextAlign.left,
                ),
                Center(
                  child: Form(
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 26.5),
                        child: TextFormField(
                          textCapitalization: TextCapitalization.sentences,

                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: underLineColor)),
                                label: const Text('Your Name'),
                                labelStyle: TextStyle(color: hintTextColor))),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: underLineColor)),
                                label: const Text('Email'),
                                labelStyle: TextStyle(color: hintTextColor))),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                        child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            textInputAction: TextInputAction.next,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: underLineColor)),
                                label: const Text('Password'),
                                labelStyle: TextStyle(color: hintTextColor))),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            textCapitalization: TextCapitalization.sentences,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: underLineColor)),
                                label: const Text('Confirm Password'),
                                labelStyle: TextStyle(color: hintTextColor))),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(

                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: underLineColor)),
                                label: const Text('Mobile Number'),
                                labelStyle: TextStyle(color: hintTextColor))),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: underLineColor)),
                                label: const Text('Gender'),
                                labelStyle: TextStyle(color: hintTextColor))),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.datetime,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: underLineColor)),
                                label: const Text('Date of birth'),
                                labelStyle: TextStyle(color: hintTextColor))),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: underLineColor)),
                                label: const Text('Country'),
                                labelStyle: TextStyle(color: hintTextColor))),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: underLineColor)),
                                label: const Text('State'),
                                labelStyle: TextStyle(color: hintTextColor))),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                        child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: underLineColor)),
                                label: const Text('City'),
                                labelStyle: TextStyle(color: hintTextColor))),
                      ),

  //SignUp Button

                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                        child: Container(
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(40)),
                          height: 50,
                          width: 400,
                          child: Center(
                            child: Text(
                              'Sign up',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      //back to sign-in Button

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Back to ',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontSize: 14, color: Colors.grey[600]),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                            },
                            child: Text(
                              ' Sign in',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      fontSize: 14,
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
