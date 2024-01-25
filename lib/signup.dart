import 'package:flutter/material.dart';
import 'package:signup_page/login.dart';
import 'package:signup_page/theme.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  String? dropdownValue;
  var genderOptions = ['male', 'female'];
  var hobbies = ['Reading', 'Cooking', 'Playing', 'Traveling', 'Gaming'];
  var selectedHobbies = [];

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   toolbarHeight: 10,
        //   backgroundColor: Colors.black,
        // ),
        body: Stack(
          children: [

            Image.asset(
              'asset/image/appbackground.jpg',
              fit: BoxFit.fill,
              width: double.maxFinite,
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
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 26.5),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textCapitalization: TextCapitalization.sentences,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: underLineColor)),
                                      label: const Text('Your Name'),
                                      labelStyle: TextStyle(color: hintTextColor)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Name';
                                    }
                                  },
                                ),
                              ),
                              //Email
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                                child: TextFormField(
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
                                    }
                                  },
                                ),
                              ),
                              //Confirm Password
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                                child: TextFormField(
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
                                    }
                                  },
                                ),
                              ),
                              //Mobile Number
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                                child: TextFormField(
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
                                    }
                                  },
                                ),
                              ),
                              //Gender
                              Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                                  child: DropdownButton(
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
                                    decoration: InputDecoration(
                      
                      
                                        border: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: underLineColor)),
                                        label: const Text('Date of birth'),
                                        labelStyle:
                                            TextStyle(color: hintTextColor)),
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2023));
                                      if (pickedDate != null &&
                                          pickedDate != DateTime.now()) {
                                        print(pickedDate);
                                      }
                                      ;
                                    }),
                              ),
                              //Country
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                                child: TextFormField(
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
                                  },
                                ),
                              ),
                              //State
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                                child: TextFormField(
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
                                  },
                                ),
                              ),
                              //City
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                                child: TextFormField(
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
                                              print(selectedHobbies);
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
                                    formKey.currentState!.validate();
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
                                      Navigator.push(
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
