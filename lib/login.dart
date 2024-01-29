
import 'package:flutter/material.dart';
import 'package:signup_page/theme.dart';

 class LoginPage extends StatefulWidget {
  const LoginPage ({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {


   final TextEditingController emailController = TextEditingController();
   final TextEditingController passwordController = TextEditingController();

    final lFormKey = GlobalKey<FormState>();

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
                    Center(
                      child: Form(
                        key: lFormKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 100, 0, 26.5),
                                child: TextFormField(
                                  controller: emailController,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: underLineColor)),
                                        label: const Text('Email'),
                                        labelStyle: TextStyle(color: hintTextColor)),
                                validator: (value){
                                    if(value == null || value.isEmpty){
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
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 26.5),
                                child: TextFormField(
                                  controller: passwordController,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true
                                    ,
                                    decoration: InputDecoration(
                                      suffix: Align(
                                        heightFactor: 1.0,
                                        widthFactor: 1.0,
                                        child: Text('Forgot?', style: TextStyle(color: primaryColor),),
                                      ),


                                        border: UnderlineInputBorder(
                                            borderSide:
                                            BorderSide(color: underLineColor)),
                                        label: const Text('Password'),
                                        labelStyle: TextStyle(color: hintTextColor)),
                                validator: (value){
                                    if(value == null || value.isEmpty){
                                      return 'Please Enter Password';
                                    } else{
                                      return null;
                                    }
                                },
                                ),
                              ),
                              //SignUp Button

                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(40)),
                                  height: 50,
                                  width: 400,
                                  child: Center(
                                    child: Text(
                                      'Sign in',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              
                              Text('or', style:
                                Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18,color: hintTextColor)
                              ,),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 36),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: buttonLightGreenBorder),
                                      color: buttonLightGreen,    //rgb(223,234,228)
                                      borderRadius: BorderRadius.circular(40)),
                                  height: 50,
                                  width: 400,
                                  child: Center(
                                    child: Text(
                                      'Sign in with Google',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontSize: 18, color: primaryColor , fontWeight: FontWeight.bold),
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
                                      Navigator.pop(context);
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
