import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:signup_page/model_class/user_model.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginWithApi>(loginWithApi);
  }

  Future<void> loginWithApi(LoginWithApi event, Emitter<LoginState> emit) async{
 try{
      var response = await http.post(Uri.parse('https://dummyjson.com/auth/login'),
           body:{ 'username' : event.userName  , 'password' : event.password  });

            UserApi user = UserApi.fromJson(jsonDecode(response.body));
             emit(UserLoggedInSuccess(userData: user));
              


  } catch(e) {
      print(e.toString());
    }
}
}
