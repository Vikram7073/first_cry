import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class SignUpState{}


class SignUpInitialState extends SignUpState{}

class SignUpErrorState extends SignUpState{
  String error;
  SignUpErrorState(this.error);
}

class SignUpLoadingState extends SignUpState{}

class SignUpSuccessState extends SignUpState{}




abstract class SignUpEvent{}

class RegisterEvent extends SignUpEvent{
  String email,password;
  RegisterEvent(this.email,this.password);
}




class SignUpBloc extends Bloc<SignUpEvent,SignUpState> {
  TextEditingController emailController = TextEditingController();
  SignUpBloc():super(SignUpInitialState()){
    on<RegisterEvent>((event, emit) async {
      emit(SignUpLoadingState());

      emit(SignUpSuccessState());
    });





  }
}


