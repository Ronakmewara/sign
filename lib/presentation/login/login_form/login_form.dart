import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/custom_button/custom_button.dart';
import '../../../common/custom_input/custom_input.dart';
import '../../../theme/theme.dart';
import '../../mainpagewithbar/mainpagewithbar.dart';
import '../../signup/signup.dart';

class LoginForm extends StatefulWidget {

  const LoginForm({super.key, });


  @override
  State<LoginForm> createState() => _LoginFormState();
}
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
bool isObscure =false;
late SharedPreferences prefs;
final lFormKey = GlobalKey<FormState>();
class _LoginFormState extends State<LoginForm> {



  @override
  void initState() {
    super.initState();
    initializePreferences();
  }

  Future<void> initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: lFormKey,
        child: Column(
          children: [
            Padding(
                padding:
                const EdgeInsets.fromLTRB(0, 100, 0, 26.5),
                child: CustomInput(
                  name: 'Email',
                  controller: emailController,
                  placeholder: 'Please Enter email',
                  keyboardStyle: TextInputType.emailAddress,
                  regexp: r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  regexNotMatchMessage:
                  'Please Enter Valid Email', obscureText: false,)),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                child: CustomInput(
                  name: 'Password',
                  controller: passwordController,
                  placeholder: 'Enter Password',
                  keyboardStyle: TextInputType.visiblePassword,
                  regexp: '',
                  regexNotMatchMessage: 'Please Enter Password', obscureText: isObscure, suffixIcon: IconButton(
                  onPressed: (){
                    setState(() {
                      isObscure = !isObscure;
                    });
                  }, icon:  Icon( isObscure ? Icons.visibility_off :  Icons.remove_red_eye_outlined ),
                ),)),
            //SignUp Button

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
              child: InkWell(
                  onTap: () {
                    if (lFormKey.currentState!.validate()) {
                      String email = emailController.text;
                      String password = passwordController.text;

                      String? userJson = prefs.getString('user');

                      if (userJson != null) {
                        Map<String, dynamic> userData =
                        json.decode(userJson);

                        if (userData['email'] == email &&
                            userData['password'] == password) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Login Successful'),
                            duration: Duration(seconds: 2),
                          ));
                          prefs.setBool('isLogged', true);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const MainPage()));
                          emailController.clear();
                          passwordController.clear();
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Incorrect Credentials'),
                            duration: Duration(seconds: 2),
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              'No Such Data Found ! Please Register '),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    }
                  },
                  child: const CustomButton(text: 'Sign in',)
              ),
            ),
            Text(
              'or',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 18, color: hintTextColor),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 36),
              child: Container(
                decoration: BoxDecoration(
                    border:
                    Border.all(color: buttonLightGreenBorder),
                    color: buttonLightGreen,
                    //rgb(223,234,228)
                    borderRadius: BorderRadius.circular(40)),
                height: 50,
                width: 400,
                child: Center(
                  child: Text(
                    'Sign in with Google',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(
                        fontSize: 18,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            //back to sign-in Button

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Create account? ',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(
                      fontSize: 14, color: Colors.grey[600]),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const Signup()));
                  },
                  child: Text(
                    ' Sign up',
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
        ));
  }
}
