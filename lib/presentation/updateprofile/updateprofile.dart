import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_page/common/custom_input/custom_input.dart';
import 'package:signup_page/presentation/mainpagewithbar/mainpagewithbar.dart';
import 'package:signup_page/presentation/signup/signup.dart';
import 'package:signup_page/theme/theme.dart';

import '../../model_class/user_sharedprefs.dart';

File? _image;
String? imagePath;
class UpdateForm extends StatefulWidget {
  const UpdateForm({super.key, required this.data});

  final Map<String, dynamic>? data;

  @override
  State<UpdateForm> createState() => _UpdateFormState();
}

class _UpdateFormState extends State<UpdateForm> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController hobbiesController = TextEditingController();

  late SharedPreferences prefs;
  final uFormKey = GlobalKey<FormState>();
  String? dropdownValue;
  var genderOptions = ['male', 'female'];
  
  void loadUserdata() async {
    setState(() {
      nameController.text = widget.data?['fullName'];
      emailController.text = widget.data?['email'];
      mobileNumberController.text = widget.data?['mobileNumber'];
      dropdownValue = widget.data?['gender'];
      dateController.text = widget.data?['dateOfBirth'];
      countryController.text = widget.data?['country'];
      cityController.text = widget.data?['city'];
      stateController.text = widget.data?['state'];
    });
     prefs = await SharedPreferences.getInstance();
  }
  ImagePicker picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    loadUserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const MainPage()));
          },
          icon:const Icon(Icons.arrow_back_ios_new), color: Colors.white ,
        ),
        title: const Center(
          child: Text(
            'Update Profile',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: uFormKey,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomInput(
                    name: 'Name',
                    placeholder: 'Enter Your Name',
                    keyboardStyle: TextInputType.text,
                    controller: nameController, regexp: '', regexNotMatchMessage: '',obscureText: false,
                  ),
                  CustomInput(
                    name: 'Email',
                    placeholder: 'Enter Your Email',
                    keyboardStyle: TextInputType.emailAddress,
                    controller: emailController, regexp: '', regexNotMatchMessage: '',obscureText: false,
                  ),
                  CustomInput(
                    name: 'Mobile number',
                    placeholder: 'Enter Your Mobile Number',
                    keyboardStyle: TextInputType.text,
                    controller: mobileNumberController, regexp: '', regexNotMatchMessage: '',obscureText: false,
                  ),
                  DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    isExpanded: true,
                    style: TextStyle(
                        color: Theme.of(context).hintColor, fontSize: 16),
                    hint: Text(
                      'Gender',
                      style: TextStyle(color: hintTextColor),
                    ),
                    value: dropdownValue,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: genderOptions.map((item) {
                      return DropdownMenuItem(value: item, child: Text(item));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  CustomInput(
                    name: 'Country',
                    placeholder: 'Enter country',
                    keyboardStyle: TextInputType.text,
                    controller: countryController, regexp: '', regexNotMatchMessage: '',obscureText: false,
                  ),
                  CustomInput(
                    name: 'State',
                    placeholder: 'Enter State',
                    keyboardStyle: TextInputType.text,
                    controller: stateController, regexp: '', regexNotMatchMessage: '', obscureText: false,
                  ),
                  CustomInput(
                    name: 'City',
                    placeholder: 'Enter City',
                    keyboardStyle: TextInputType.text,
                    controller: cityController, regexp: '', regexNotMatchMessage: '', obscureText: false,
                  ),

                  const SizedBox(
                    height: 0,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                          onPressed: () {
                            pickImage();
                          },
                          child: const Text('Update Your Profile Picture'),
                        ),
                      ),
                      if(imagePath != null)
                        Container(
                          height:50,
                          width: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white),
                          child: ClipOval(
                              child:Image.file(File(imagePath!),
                                fit: BoxFit.cover,
                              ) ),
                        ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      User updatedUser = User(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          mobileNumber: mobileNumberController.text,
                          dateOfBirth: dateController.text,
                          country: countryController.text,
                          city: cityController.text,
                          state: stateController.text,
                          gender: dropdownValue!,
                           );

                    String user = json.encode(updatedUser.toJson());
                    print(user);
                    prefs.setString('user',user );

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Details Updated'),
                    ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(40)),
                      height: 50,
                      width: 400,
                      child: Center(
                        child: Text(
                          'Update',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
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
