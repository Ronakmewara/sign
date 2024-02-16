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

class User {
  String? name;
  String? email;
  String? password;
  String? mobileNumber;
  String? dateOfBirth;
  String? country;
  String? state;
  String? city;
  List<String>? hobbies;
  String? gender;

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

  User.fromJson(Map<String , dynamic> json){
    name = json['Name'];
    email = json['Email'];
    password = json['Password'];
    mobileNumber = json['Mobile Number'];
    dateOfBirth = json['DateOfBirth'];
    country = json['Country'];
    city = json['City'];
    gender = json['Gender'];
    state = json['State'];
    hobbies = json['Hobbies'];

  }
}

File? _image;
String? imagePath;

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
  ImagePicker picker = ImagePicker();

  //controllers

  final TextEditingController dateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController hobbiesController = TextEditingController();

  //User Class
var formBuilderData;
  final formKey = GlobalKey<FormBuilderState>();

  //sharedpref signUp login
  void signup() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

      String userJson = json.encode(formBuilderData);
    await prefs.setString('user', userJson);




    // String name = nameController.text.trim();
    // String email = emailController.text;
    // String password = passwordController.text;
    // String mobileNumber = mobileNumberController.text;
    //
    // String dateOfBirth = dateController.text;
    // String country = countryController.text;
    // String state = stateController.text;
    // String city = cityController.text;


    // User user = User(
    //     name: name,
    //     email: email,
    //     password: password,
    //     mobileNumber: mobileNumber,
    //     dateOfBirth: dateOfBirth,
    //     country: country,
    //     city: city,
    //     state: state,
    //     hobbies: hobbies,
    //     gender: gender);

    // String userJson = json.encode(user.toJson());

    // await prefs.setString('user', userJson);

    //clearing Input Fields

     // )

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
                              )

                              // DropdownButtonFormField(
                              //   autovalidateMode:
                              //       AutovalidateMode.onUserInteraction,
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return 'Please Enter Your Gender';
                              //     } else {
                              //       return null;
                              //     }
                              //   },
                              //   isExpanded: true,
                              //   style: TextStyle(
                              //       color: Theme.of(context).hintColor,
                              //       fontSize: 16),
                              //   hint: Text(
                              //     'Gender',
                              //     style: TextStyle(color: hintTextColor),
                              //   ),
                              //   value: dropdownValue,
                              //   icon: const Icon(Icons.keyboard_arrow_down),
                              //   items: genderOptions.map((item) {
                              //     return DropdownMenuItem(
                              //         value: item, child: Text(item));
                              //   }).toList(),
                              //   onChanged: (String? newValue) {
                              //     setState(() {
                              //       dropdownValue = newValue!;
                              //     });
                              //   },
                              // )

                              ),
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
                            child:
                            Column(
                              children: [
                                Text(
                                  'Select Your Hobbies',
                                  style: TextStyle(
                                      color: hintTextColor, fontSize: 17),
                                ),
                                Column(children: [
                                  FormBuilderCheckboxGroup(
                                    wrapVerticalDirection: VerticalDirection.down,
                                      name: 'Hobbies',
                                      options:hobbies.map((e) {
                                        return FormBuilderFieldOption(value: e);
                                      }).toList())
                                ])
                              ],
                            ),
                            // Column(
                            //   children: [
                            //     Text(
                            //       'Select Your Hobbies',
                            //       style: TextStyle(
                            //           color: hintTextColor, fontSize: 17),
                            //     ),
                            //     Column(
                            //       children: hobbies.map((hobby) {
                            //         return CheckboxListTile(
                            //           title: Text(hobby),
                            //           value: selectedHobbies.contains(hobby),
                            //           onChanged: (value) {
                            //             setState(() {
                            //               if (value!) {
                            //                 selectedHobbies.add(hobby);
                            //               } else {
                            //                 selectedHobbies.remove(hobby);
                            //               }
                            //             });
                            //           },
                            //         );
                            //       }).toList(),
                            //     )
                            //   ],
                            // ),
                          ),

                          //SignUp Button

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                            child: InkWell(
                                onTap: () {
                                 if(formKey.currentState!.saveAndValidate()){
                                   formBuilderData = formKey.currentState?.value;
                                   Signup();
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





                                  // if (formKey.currentState!.validate()) {
                                  //   debugPrint(formKey.currentState?.value.toString());
                                  //   signup();
                                  //   Navigator.pushReplacement(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               const LoginPage()));
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //       const SnackBar(
                                  //           content:
                                  //               Text('Signup Successfully!')));
                                  // }
                                },
                                child: const CustomButton(
                                  text: 'Sign up',
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
