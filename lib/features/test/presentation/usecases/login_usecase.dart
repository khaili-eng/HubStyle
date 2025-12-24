import 'package:untitled7/features/test/repo/auth_repository.dart';

class LoginUseCase{
  final AuthRepository repo;
  LoginUseCase(this.repo);
  Future<String> call(String email,String password){
    return repo.login(password, email);
  }
}