import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DistrictEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetDistricts extends DistrictEvent {
  final int cityID;

  GetDistricts({@required this.cityID});

  @override
  // TODO: implement props
  List<Object> get props => [cityID];
}
