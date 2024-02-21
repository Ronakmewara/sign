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

             if(response.statusCode == 200 ){
               UserApi user = UserApi.fromJson(jsonDecode(response.body));
               emit(UserLoggedInSuccess(userData: user));
             } else if(response.statusCode == 401){
               emit(ErrorState(message : 'Invalid Credentials'));
             }
             else{
               emit(ErrorState(message: 'An Invalid Error Occurs ! status Code: ${response.statusCode}'));
             }
  } catch(e) {
   emit(ErrorState(message: 'An Error Occured : $e'));
      print(e.toString());
    }
}
}
