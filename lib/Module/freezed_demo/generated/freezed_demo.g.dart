// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freezed_demo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserListImpl _$$UserListImplFromJson(Map<String, dynamic> json) =>
    _$UserListImpl(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      isActive: json['isActive'] as bool? ?? false,
    );

Map<String, dynamic> _$$UserListImplToJson(_$UserListImpl instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'isActive': instance.isActive,
    };
