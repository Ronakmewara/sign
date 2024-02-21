import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:signup_page/Module/blocloginapi/bloc/login_bloc.dart';

import '../../../common/custom_button/custom_button.dart';
import '../../../theme/theme.dart';

class LoginFormBloc extends StatefulWidget {
  const LoginFormBloc({super.key});

  @override
  State<LoginFormBloc> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginFormBloc> {

  final LoginBloc loginBloc = LoginBloc();

  String? userName;
  String? password;

  bool hidePassword = true;
  final blocFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Login using API'),),
    body: SingleChildScrollView(
      child: Column(
          children: [
      
      
            Padding(
              padding: const EdgeInsets.only(left: 20 , right: 20),
              child: FormBuilder(
                key: blocFormKey,
                child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 100, 0, 26.5),
                          child: FormBuilderTextField(
                            keyboardType: TextInputType.text,
                            name: 'Username',
                            decoration: InputDecoration(
                                label: Text(
                                  'Enter Username',
                                  style: TextStyle(color: hintTextColor),
                                )),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
      
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
                                  hidePassword ? Icons.visibility_off : Icons
                                      .visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: hidePassword,
                          )),
                      //SignUp Button
      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 8),
                        child: InkWell(
                            onTap: () {
                              if (blocFormKey.currentState!.saveAndValidate()) {
                                userName =
                                blocFormKey.currentState?.value['Username'];
                                password =
                                blocFormKey.currentState?.value['Password'];
                                loginBloc.add(LoginWithApi(
                                    userName: userName, password: password));
                              }
                            },
                            child: const CustomButton(
                              text: 'Sign in',
                            )),
      
                      ),
      
      
                    ])
      
                      ),
            ),
            BlocConsumer<LoginBloc, LoginState>(
              bloc: loginBloc,
              listener: (context, state) {
      
              },
              builder: ( context, state) {
                print(state);
                if(state is UserLoggedInSuccess){
                  return Column(
                    children: [
                      Text('Logged In Succesfully' , style: TextStyle(fontSize: 20 , color: Colors.green),),
                      Container(
                        child: Column(
                          children: [
                            Text('hello ${state.userData.firstName}'),
                            Text('Your Email is ${state.userData.email}')
                          ],
                        ),
                      )
                    ],
                  );
                  
                  
                } else {
                  return Text('some Error Occured');
                }
      
              },
            ) ,
      
          ]
      
      
      ),
    ) ,
    ) ;
  }
}
