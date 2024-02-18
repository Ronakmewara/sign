import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signup_page/common/custom_input/custom_input.dart';
import 'package:signup_page/presentation/mainpagewithbar/mainpagewithbar.dart';
import 'package:signup_page/presentation/signup/signup.dart';
import 'package:signup_page/theme/theme.dart';

import '../../common/custom_button/custom_button.dart';
import '../../model_class/user_sharedprefs.dart';

File? _image;
String? imagePath;
class UpdateForm extends StatefulWidget {
  const UpdateForm({super.key, required this.data});
  final data;


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
  final formKey = GlobalKey<FormBuilderState>();

  var genderOptions = ['male', 'female'];
  Map<String, dynamic>? updateFormBuilderData;


  void loadUserdata() async {
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
        child: FormBuilder(
            key: formKey,
            child: Column(
              children: [
                //Name
                Padding(
                    padding:
                    const EdgeInsets.fromLTRB(0, 20, 0, 26.5),
                    child: FormBuilderTextField(
                      initialValue: widget.data.name??"",
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
                      initialValue: widget.data.email??"",
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


                //Mobile Number
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                    child: FormBuilderTextField(
                      initialValue: widget.data.mobileNumber??"" ,
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
                      initialValue: widget.data.gender??"",
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

                ),
                //Date Of birth
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                  child: FormBuilderDateTimePicker(
                  initialValue:  DateTime.parse(widget.data.dateOfBirth) ,
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
                      initialValue: widget.data.country??"",
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
                      initialValue: widget.data.state??"",
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
                      initialValue: widget.data.city??"",
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
                        const Text('Update Your Profile Picture'),
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


                //SignUp Button

                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 40),
                  child: InkWell(
                      onTap: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        if (formKey.currentState!.saveAndValidate()) {


                          //date of birth is Type of DATETIME so converting it to String
                          updateFormBuilderData?['Date of birth'] = (updateFormBuilderData?['Date of birth'] as DateTime).toIso8601String();

                          String userJson = json.encode(updateFormBuilderData);
                          print(userJson);
                          await prefs.setString('user', userJson);
                          // Navigator.pushReplacement(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             const LoginPage()));
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                  Text('Details Updated Successfully')));
                        }


                      },
                      child: const CustomButton(
                        text: 'Update Details',
                      )),
                ),

                //back to sign-in Button


              ],
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
