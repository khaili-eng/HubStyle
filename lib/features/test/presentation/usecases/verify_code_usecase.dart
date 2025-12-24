import 'package:untitled7/features/test/repo/auth_repository.dart';

class VerifyCodeUseCase{
  final AuthRepository repo;
  VerifyCodeUseCase(this.repo);
  Future<bool> call(String code){
    return repo.verifyCode(code);
  }
}