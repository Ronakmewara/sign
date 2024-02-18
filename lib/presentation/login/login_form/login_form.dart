import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/custom_button/custom_button.dart';
import '../../../common/custom_input/custom_input.dart';
import '../../../model_class/user_sharedprefs.dart';
import '../../../theme/theme.dart';
import '../../mainpagewithbar/mainpagewithbar.dart';
import '../../signup/signup.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
bool isObscure = true;
late SharedPreferences prefs;
final lFormKey = GlobalKey<FormBuilderState>();

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
    return FormBuilder(
        key: lFormKey,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 26.5),
                child: FormBuilderTextField(
                  keyboardType: TextInputType.emailAddress,
                  name: 'Email',
                  decoration: InputDecoration(
                      label: Text(
                    'Enter Email',
                    style: TextStyle(color: hintTextColor),
                  )),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email()
                  ]),
                )),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                child: FormBuilderTextField(
                  name: 'Password',
                  decoration: InputDecoration(
                    labelText: 'Enter Password',
                    labelStyle: TextStyle(color: hintTextColor),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: isObscure,
                )),
            //SignUp Button

            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
              child: InkWell(
                  onTap: () {
                    if (lFormKey.currentState!.saveAndValidate()) {


                      String? userJson = prefs.getString('user');

                      if (userJson != null) {
                        User userData = User.fromJson(json.decode(userJson));
                        if (userData.email == lFormKey.currentState!.value['Email'] &&
                            userData.password == lFormKey.currentState!.value['Password']) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('Login Successful'),
                            duration: Duration(seconds: 2),
                          ));
                          prefs.setBool('isLogged', true);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()));
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
                          content:
                              Text('No Such Data Found ! Please Register '),
                          duration: Duration(seconds: 2),
                        ));
                      }
                    }
                  },
                  child: const CustomButton(
                    text: 'Sign in',
                  )),
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
                    border: Border.all(color: buttonLightGreenBorder),
                    color: buttonLightGreen,
                    //rgb(223,234,228)
                    borderRadius: BorderRadius.circular(40)),
                height: 50,
                width: 400,
                child: Center(
                  child: Text(
                    'Sign in with Google',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                      .copyWith(fontSize: 14, color: Colors.grey[600]),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Signup()));
                  },
                  child: Text(
                    ' Sign up',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
