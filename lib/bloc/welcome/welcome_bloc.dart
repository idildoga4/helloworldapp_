import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helloworld/bloc/welcome/welcome_events.dart';
import 'package:helloworld/bloc/welcome/welcome_states.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(Page1State()) {
    on<TogglePage>(_onTogglePage);
  }

  void _onTogglePage(TogglePage event, Emitter<PageState> emit) {
    if (state is Page1State) {
      emit(Page2State());
    } else if (state is Page2State) {
      emit(Page1State());
    }
  }
}
