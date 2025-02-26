// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    username: json['username'] as String,
    password: json['password'] as String,
    fullname: json['fullname'] as String,
    gender: json['gender'] as int,
    dateOfBirth: json['dateOfBirth'] == null
        ? null
        : DateTime.parse(json['dateOfBirth'] as String),
    address: json['address'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    avatar: json['avatar'] as String,
    role: json['role'] as String,
    city: json['city'] as int,
    cityName: json['cityName'] as String,
    district: json['district'] as int,
    districtName: json['districtName'] as String,
    ward: json['ward'] as int,
    wardName: json['wardName'] as String,
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'fullname': instance.fullname,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'address': instance.address,
      'phone': instance.phone,
      'email': instance.email,
      'avatar': instance.avatar,
      'role': instance.role,
      'city': instance.city,
      'cityName': instance.cityName,
      'district': instance.district,
      'districtName': instance.districtName,
      'ward': instance.ward,
      'wardName': instance.wardName,
      'status': instance.status,
    };
