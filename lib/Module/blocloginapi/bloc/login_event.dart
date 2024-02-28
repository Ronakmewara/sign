part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginWithApi extends LoginEvent{
final String? userName;
final String? password;

  LoginWithApi({required this.userName , required this.password});
}