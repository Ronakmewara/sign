part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class UserLoggedInSuccess extends LoginState{
 final UserApi userData;

  UserLoggedInSuccess({required this.userData});
}

class LoadingState extends LoginState{}
class ErrorState extends LoadingState{
 final String message;

  ErrorState({required this.message});

}