import 'package:equatable/equatable.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object> get props => [];
}

class Page1State extends PageState {}

class Page2State extends PageState {}
