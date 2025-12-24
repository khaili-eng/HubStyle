import 'package:untitled7/features/test/data/data_source/auth_remote_ds.dart';
import 'package:untitled7/features/test/repo/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository{
  final AuthRemoteDataSource remote;
  AuthRepositoryImpl(this.remote);
  @override
  Future<String>login(String email,String password){
    return remote.login(password, email);
  }
  @override
  Future<void>register(String fullName,String email,String address,String password){
    return remote.register(fullName, email, address, password);
  }
  @override
  Future<void>forgetPassword(String email){
    return remote.forgetPassword(email);
  }
  @override
  Future<bool> verifyCode(String code){
    return remote.verifyCode(code);
  }
}