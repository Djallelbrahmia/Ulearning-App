import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_teacher_bloc/pages/sign-in/bloc/signin_events.dart';
import 'package:learn_teacher_bloc/pages/sign-in/bloc/signin_states.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInState()) {
    on<UsernameEvent>(_emailEvent);

    on<PasswordEvent>(_passwordEvent);
  }
  void _emailEvent(UsernameEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(username: event.username));
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(password: event.password));
  }
}
