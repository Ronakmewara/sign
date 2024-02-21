part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class UserLoggedInSuccess extends LoginState{
 final UserApi userData;

  UserLoggedInSuccess({required this.userData});
}