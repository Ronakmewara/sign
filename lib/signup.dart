import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_page/custom_input.dart';
import 'package:signup_page/login.dart';
import 'package:signup_page/theme.dart';
import 'package:intl/intl.dart';

class User {
  String name;
  String email;
  String password;
  String mobileNumber;
  String dateOfBirth;
  String country;
  String state;
  String city;
  List<String>? hobbies;
  String gender;

  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.mobileNumber,
      required this.dateOfBirth,
      required this.country,
      required this.city,
      required this.state,
      this.hobbies,
      required this.gender});

  Map<String, dynamic> toJson() {
    return {
      'fullName': name,
      'email': email,
      'password': password,
      'mobileNumber': mobileNumber,
      'dateOfBirth': dateOfBirth,
      'country': country,
      'city': city,
      'gender': gender,
      'state': state,
      'hobbies': hobbies
    };
  }
}

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  String? dropdownValue;
  var genderOptions = ['male', 'female'];
  List<String> hobbies = [
    'Reading',
    'Cooking',
    'Playing',
    'Traveling',
    'Gaming'
  ];
  List<String> selectedHobbies = [];

  //controllers

  final TextEditingController dateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController hobbiesController = TextEditingController();

  //User Class

  final formKey = GlobalKey<FormState>();

  //sharedpref signUp login
  void signup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = nameController.text.trim();
    String email = emailController.text;
    String password = passwordController.text;
    String mobileNumber = mobileNumberController.text;
    String? gender = dropdownValue;
    String dateOfBirth = dateController.text;
    String country = countryController.text;
    String state = stateController.text;
    String city = cityController.text;
    var hobbies = selectedHobbies;

    User user = User(
        name: name,
        email: email,
        password: password,
        mobileNumber: mobileNumber,
        dateOfBirth: dateOfBirth,
        country: country,
        city: city,
        state: state,
        hobbies: hobbies,
        gender: gender!);

    String userJson = json.encode(user.toJson());

    await prefs.setString('user', userJson);

    //clearing Input Fields

    nameController.clear();
    dateController.clear();
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    mobileNumberController.clear();
    dateOfBirthController.clear();
    countryController.clear();
    stateController.clear();
    cityController.clear();
    hobbiesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          'asset/image/appbackground.jpg',
          fit: BoxFit.fill,
          width: double.maxFinite,
          height: double.maxFinite,
        ),
        SingleChildScrollView(
          child: Padding(
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
                      key: formKey,
                      child: Column(
                        children: [
                          //Name
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 20, 0, 26.5),
                              child: CustomInput(
                                  name: 'Name',
                                  controller: nameController,
                                  placeholder: 'Enter Your Name',
                                  keyboardStyle: TextInputType.text)),
                          //Email
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                            child: TextFormField(
                              controller: emailController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: underLineColor)),
                                  label: const Text('Email'),
                                  labelStyle: TextStyle(color: hintTextColor)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Email';
                                } else if (!RegExp(
                                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value)) {
                                  return 'Please Enter valid Email';
                                }
                                return null;
                              },
                            ),
                          ),

                          //Password

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                            child: TextFormField(
                              controller: passwordController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textCapitalization: TextCapitalization.sentences,
                              textInputAction: TextInputAction.next,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: underLineColor)),
                                  label: const Text('Password'),
                                  labelStyle: TextStyle(color: hintTextColor)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Password';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          //Confirm Password
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                            child: TextFormField(
                              controller: confirmPasswordController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: underLineColor)),
                                  label: const Text('Confirm Password'),
                                  labelStyle: TextStyle(color: hintTextColor)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Password';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          //Mobile Number
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                            child: TextFormField(
                              controller: mobileNumberController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: underLineColor)),
                                  label: const Text('Mobile Number'),
                                  labelStyle: TextStyle(color: hintTextColor)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Mobile Number';
                                } else if (!RegExp(r"^[0-9]{10}$")
                                    .hasMatch(value)) {
                                  return 'Mobile Number must be of 10 digit';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          //Gender
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                              child: DropdownButtonFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Your Gender';
                                  } else {
                                    return null;
                                  }
                                },
                                isExpanded: true,
                                style: TextStyle(
                                    color: Theme.of(context).hintColor,
                                    fontSize: 16),
                                hint: Text(
                                  'Gender',
                                  style: TextStyle(color: hintTextColor),
                                ),
                                value: dropdownValue,
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: genderOptions.map((item) {
                                  return DropdownMenuItem(
                                      value: item, child: Text(item));
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                              )),
                          //Date Of birth
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Your Date Of Birth';
                                } else {
                                  return null;
                                }
                              },
                              readOnly: true,
                              controller: dateController,
                              decoration: InputDecoration(
                                label: Text(
                                  'Date of birth',
                                  style: TextStyle(color: hintTextColor),
                                ),
                              ),
                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(2023, 1, 1),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2023, 12, 31));
                                if (picked != null) {
                                  setState(() {
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy').format(picked);
                                    dateController.text = formattedDate;
                                  });
                                }
                              },
                            ),
                          ),
                          //Country
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                            child: TextFormField(
                              controller: countryController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: underLineColor)),
                                  label: const Text('Country'),
                                  labelStyle: TextStyle(color: hintTextColor)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Country';
                                }
                                return null;
                              },
                            ),
                          ),
                          //State
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                            child: TextFormField(
                              controller: stateController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: underLineColor)),
                                  label: const Text('State'),
                                  labelStyle: TextStyle(color: hintTextColor)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter State';
                                }
                                return null;
                              },
                            ),
                          ),
                          //City
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                            child: TextFormField(
                              controller: cityController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: underLineColor)),
                                  label: const Text('City'),
                                  labelStyle: TextStyle(color: hintTextColor)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter City';
                                }
                                return null;
                              },
                            ),
                          ),
                          //Hobbies
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Column(
                              children: [
                                Text(
                                  'Select Your Hobbies',
                                  style: TextStyle(
                                      color: hintTextColor, fontSize: 17),
                                ),
                                Column(
                                    children: hobbies.map((hobby) {
                                  return CheckboxListTile(
                                    title: Text(hobby),
                                    value: selectedHobbies.contains(hobby),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value!) {
                                          selectedHobbies.add(hobby);
                                        } else {
                                          selectedHobbies.remove(hobby);
                                        }
                                      });
                                    },
                                  );
                                }).toList())
                              ],
                            ),
                          ),

                          //SignUp Button

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                            child: InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  signup();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Signup Successfully!')));
                                }
                              },
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
                                        .copyWith(
                                            fontSize: 18, color: Colors.white),
                                  ),
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
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
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
          ),
        )
      ],
    ));
  }
}
