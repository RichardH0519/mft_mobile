import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String username;
  final String password;
  final String fullname;
  final int gender;
  final DateTime dateOfBirth;
  final String address;
  final String phone;
  final String email;
  final String avatar;
  final String role;
  final int city;
  final String cityName;
  final int district;
  final String districtName;
  final int ward;
  final String wardName;
  /*final double latitude;
  final double longitude;*/
  final int status;

  User({
    this.username,
    this.password,
    this.fullname,
    this.gender,
    this.dateOfBirth,
    this.address,
    this.phone,
    this.email,
    this.avatar,
    this.role,
    this.city,
    this.cityName,
    this.district,
    this.districtName,
    this.ward,
    this.wardName,
    /*this.latitude,
    this.longitude,*/
    this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
