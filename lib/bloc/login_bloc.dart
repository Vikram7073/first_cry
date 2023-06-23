// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../constant/apputill.dart';
//
//
// abstract class LoginState{}
//
//
// class LoginInitialState extends LoginState{}
//
// class LoginErrorState extends LoginState{
//   String error;
//
//   LoginErrorState(this.error);
// }
//
// class LoginLoadingState extends LoginState{}
//
// class LoginSuccessState extends LoginState{
//
//   String verificationId;
//
//   LoginSuccessState(this.verificationId);
// }
//
//
//
//
// abstract class LoginEvent{}
//
// class ButtonSubmitEvent extends LoginEvent{
//   String phone ;
//
//   ButtonSubmitEvent(this.phone);
// }
//
//
//
//
// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//    TextEditingController phoneController = TextEditingController();
//
//   String? varId;
//
//   Future<String?> verifyPhoneNumber() async {
//
//   }
//
//   LoginBloc():super(LoginInitialState()){
//     on<ButtonSubmitEvent>((event, emit) async {
//       emit(LoginLoadingState());
//
//       try{
//         FirebaseAuth auth = FirebaseAuth.instance;
//         await  auth.verifyPhoneNumber(
//             phoneNumber: "+91${phoneController.text}",
//             verificationCompleted: (phonesAuthCredentials) async {
//               print('phonesAuthCredentials');
//             },
//             verificationFailed: (verificationFailed) async {
//               print('verificationFailed');
//             },
//             codeSent: (verificationId, reseningToken) async {
//               varId = verificationId;
//               await AppUtils().setToken(reseningToken.toString());
//
//             },
//             codeAutoRetrievalTimeout: (verificationId) async {}
//         ).whenComplete(() =>   emit(LoginSuccessState(varId.toString()))) ;
//
//
//       }
//       catch(e){
//         emit(LoginErrorState('Something went wrong'));
//         print(e);
//       }
//
//     });
//
//
//
//   }
// }
//
//
