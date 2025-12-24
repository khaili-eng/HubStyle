import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled7/features/test/presentation/manager/auth_state.dart';
import 'package:untitled7/features/test/presentation/usecases/forget_password_usecase.dart';
import 'package:untitled7/features/test/presentation/usecases/login_usecase.dart';
import 'package:untitled7/features/test/presentation/usecases/register_usecase.dart';

import '../usecases/verify_code_usecase.dart';

class AuthCubit extends Cubit<AuthState>{
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final VerifyCodeUseCase verifyCodeUseCase;
  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.forgetPasswordUseCase,
    required this.verifyCodeUseCase,}):super(AuthInitial());

  Future<void>login(String email,String password)async{
    emit(AuthLoading());
    try{
      final token = await loginUseCase(email,password);
      emit(AuthSuccess(token: token));
    }catch(e){
      emit(AuthFailure(e.toString()));
    }
  }
Future<void> register(String fullName,String email,String address,String password)async{
    emit(AuthLoading());
    try{
      await registerUseCase(fullName,email,address,password);
      emit(AuthSuccess());
    }catch(e){
      emit(AuthFailure(e.toString()));
    }
}
Future<void> forgetPassword(String email)async{
    emit(AuthLoading());
    try{
      await forgetPasswordUseCase( email);
      emit(AuthSuccess());
    }catch(e){
      emit(AuthFailure(e.toString()));
    }
}
Future<void> verifyCode(String code) async{
    emit(AuthLoading());
    try{
      await verifyCode(code);
      emit(AuthSuccess());
    }catch(e){
      emit(AuthFailure("Invalid verification code"));
    }
}
}