import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:signup_page/Module/blocloginapi/bloc/login_bloc.dart';
import 'package:signup_page/router/router_constants.dart';

import '../../../common/custom_button/custom_button.dart';
import '../../../theme/theme.dart';

class LoginFormNew extends StatefulWidget {
  const LoginFormNew({super.key});

  @override
  State<LoginFormNew> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginFormNew> {

  String? userName;
  String? password;

  bool hidePassword = true;
  final blocFormKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new), onPressed: (){context.go(RouterConstants.appListRoute);},),
          title: const Text('Login using API'),
        ),
        body: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: FormBuilder(
                      key: blocFormKey,
                      child: Column(children: [
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
                                    hidePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
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
                                  // LoginBloc.add(LoginWithApi(
                                  //     userName: userName, password: password));
                                  BlocProvider.of<LoginBloc>(context).add(LoginWithApi(userName: userName, password: password));
                                }
                              },
                              child:  CustomButton(
                                text: 'Sign in',color: primaryColor,
                              )),
                        ),
                      ])),
                ),
                BlocConsumer<LoginBloc, LoginState>(

                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is UserLoggedInSuccess) {
                        return Column(
                          children: [
                            const Text(
                              'Logged In Successfully',
                              style: TextStyle(fontSize: 20, color: Colors.green),
                            ),
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
                      } else if (state is ErrorState) {
                        return Text(state.message);
                      }
                      return const SizedBox();
                    }),
              ]),
            );
          }
        ),
      ),
    );
  }
}
