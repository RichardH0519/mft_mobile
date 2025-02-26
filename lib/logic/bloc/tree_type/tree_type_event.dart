import 'package:equatable/equatable.dart';

abstract class TreeTypeEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GetTreeType extends TreeTypeEvent {}
