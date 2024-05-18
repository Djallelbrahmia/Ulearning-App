import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_teacher_bloc/pages/welcome/bloc/welcome_events.dart';
import 'package:learn_teacher_bloc/pages/welcome/bloc/welcome_states.dart';

class WelcomeBloc extends Bloc<WelcomeEvents, WelcomeState> {
  WelcomeBloc() : super(WelcomeState(page: 0)) {
    on<WelcomeEvents>((event, emit) => emit(WelcomeState(page: state.page)));
  }
}
