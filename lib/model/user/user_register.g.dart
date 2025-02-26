// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRegister _$UserRegisterFromJson(Map<String, dynamic> json) {
  return UserRegister(
    username: json['username'] as String,
    password: json['password'] as String,
    fullname: json['fullname'] as String,
    gender: json['gender'] as int,
    dateOfBirth: json['dateOfBirth'] as String,
    address: json['address'] as String,
    city: json['city'] as int,
    district: json['district'] as int,
    ward: json['ward'] as int,
    phone: json['phone'] as String,
    email: json['email'] as String,
    avatar: json['avatar'] as String,
    interestTree1: json['interestTree1'] as int,
    interestTree2: json['interestTree2'] as int,
    interestTree3: json['interestTree3'] as int,
  );
}

Map<String, dynamic> _$UserRegisterToJson(UserRegister instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'fullname': instance.fullname,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth,
      'address': instance.address,
      'city': instance.city,
      'district': instance.district,
      'ward': instance.ward,
      'phone': instance.phone,
      'email': instance.email,
      'avatar': instance.avatar,
      'interestTree1': instance.interestTree1,
      'interestTree2': instance.interestTree2,
      'interestTree3': instance.interestTree3,
    };
