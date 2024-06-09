import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NavigationEvent {}

class NavigateToPage extends NavigationEvent {
  final int index;
  NavigateToPage(this.index);
}

abstract class NavigationState {}

class PageInitial extends NavigationState {}

class PageHome extends NavigationState {}

class PageCamera extends NavigationState {}

class PageMap extends NavigationState {}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(PageInitial()) {
    on<NavigateToPage>((event, emit) {
      switch (event.index) {
        case 0:
          emit(PageHome());
          break;
        case 1:
          emit(PageCamera());
          break;
        case 2:
          emit(PageMap());
          break;
      }
    });
  }
}
