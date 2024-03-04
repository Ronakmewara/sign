import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_demo.freezed.dart';
part 'freezed_demo.g.dart'

@freezed
abstract class User with _$User{
  const factory User({required String firstName , required String lastName , required String email , @Default(false) bool isActive}) = _User;


  factory User.fromJson(Map<String , dynamic>json) => _$UserFromJson(json);
}

