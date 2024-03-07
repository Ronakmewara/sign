import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_demo.freezed.dart';

part 'freezed_demo.g.dart';

@freezed
abstract class UserList with _$UserList {
  const factory UserList(
      {required String firstName,
      required String lastName,
      required String email,
      @Default(false) bool isActive}) = _UserList;

  factory UserList.fromJson(Map<String, dynamic> json) =>
      _$UserListFromJson(json);
}
