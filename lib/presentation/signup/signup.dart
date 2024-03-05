import 'dart:convert';
import 'dart:io';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_page/common/custom_input/custom_input.dart';
import 'package:signup_page/presentation/login/login.dart';
import 'package:signup_page/theme/theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../common/custom_button/custom_button.dart';

File? _image;


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => SignupState();
}

class SignupState extends State<Signup> {
  String? imagePath;
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
  ImagePicker picker = ImagePicker();

  //controllers

  //User Class

  final formKey = GlobalKey<FormBuilderState>();

  //sharedpref signUp login
  Map<String, dynamic>? formBuilderData;

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
                  child: FormBuilder(
                      key: formKey,
                      child: Column(
                        children: [
                          //Name
                          Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(0, 20, 0, 26.5),
                              child: FormBuilderTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                name: 'Name',
                                decoration: InputDecoration(
                                    label: Text(
                                  'Enter Name',
                                  style: TextStyle(color: hintTextColor),
                                )),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              )),
                          //Email
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                              child: FormBuilderTextField(
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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

                          //Password

                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                              child: FormBuilderTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                name: 'Password',
                                decoration: InputDecoration(
                                    label: Text(
                                  'Enter Password',
                                  style: TextStyle(color: hintTextColor),
                                )),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.minLength(6)
                                ]),
                              )),
                          //Confirm Password
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                              child: FormBuilderTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                name: 'Confirm Password',
                                decoration: InputDecoration(
                                    label: Text(
                                  'Confirm Password',
                                  style: TextStyle(color: hintTextColor),
                                )),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.minLength(6)
                                ]),
                              )),
                          //Mobile Number
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                              child: FormBuilderTextField(
                                keyboardType: TextInputType.number,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                name: 'Mobile Number',
                                decoration: InputDecoration(
                                    label: Text(
                                  'Enter Mobile Number',
                                  style: TextStyle(color: hintTextColor),
                                )),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                  FormBuilderValidators.minLength(10)
                                ]),
                              )),

                          //Gender
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                              child: FormBuilderDropdown(
                                name: 'gender',
                                decoration: const InputDecoration(
                                  labelText: 'Gender',
                                  hintText: 'Select Gender',
                                ),
                                items: genderOptions
                                    .map((gender) => DropdownMenuItem(
                                        alignment: Alignment.centerLeft,
                                        value: gender,
                                        child: Text(gender)))
                                    .toList(),
                              )),
                          //Date Of birth
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                            child: FormBuilderDateTimePicker(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                label: Text(
                                  'Date of birth',
                                  style: TextStyle(color: hintTextColor),
                                ),
                              ),
                              name: 'Date of birth',
                              format: DateFormat('yyyy-MM-dd'),
                            ),
                          ),
                          //Country
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                              child: FormBuilderTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                name: 'Country',
                                decoration: InputDecoration(
                                    label: Text(
                                  'Country',
                                  style: TextStyle(color: hintTextColor),
                                )),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              )),
                          //State
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                              child: FormBuilderTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                name: 'State',
                                decoration: InputDecoration(
                                    label: Text(
                                  'State',
                                  style: TextStyle(color: hintTextColor),
                                )),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              )),
                          //City
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                              child: FormBuilderTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                name: 'City',
                                decoration: InputDecoration(
                                    label: Text(
                                  'City',
                                  style: TextStyle(color: hintTextColor),
                                )),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(),
                                ]),
                              )),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: ElevatedButton(
                                  onPressed: () {
                                    pickImage();
                                  },
                                  child:
                                      const Text('Choose Your Profile Picture'),
                                ),
                              ),
                              if (imagePath != null)
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(25),
                                      color: Colors.white),
                                  child: ClipOval(
                                      child: Image.file(
                                    File(imagePath!),
                                    fit: BoxFit.cover,
                                  )),
                                ),
                            ],
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
                                Column(children: [
                                  FormBuilderCheckboxGroup(
                                      wrapVerticalDirection:
                                          VerticalDirection.down,
                                      name: 'Hobbies',
                                      options: hobbies.map((e) {
                                        return FormBuilderFieldOption(value: e);
                                      }).toList())
                                ])
                              ],
                            ),
                          ),

                          //SignUp Button

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                            child: InkWell(
                                onTap: () async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  if (formKey.currentState!.saveAndValidate()) {
                                    //FormBuilder gives us Immutable so creating Map copy and then conversion!!
                                    formBuilderData = Map<String, dynamic>.from(
                                        formKey.currentState!.value);
                                    //date of birth is Type of DATETIME so converting it to String
                                    formBuilderData?['Date of birth'] =
                                        (formBuilderData?['Date of birth']
                                                as DateTime)
                                            .toIso8601String();

                                    String userJson =
                                        json.encode(formBuilderData);

                                    await prefs.setString('user', userJson);


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
                                child:  CustomButton(
                                  text: 'Sign up', color: primaryColor,
                                )),
                          ),

                          //back to sign-in Button

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Back to',
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
                                  'Sign in',
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

  void pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      saveImage(pickedImage.path.toString());
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void saveImage(String val) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('image', val);
    loadImage();
  }

  void loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      imagePath = prefs.getString('image');
    });
  }
}
