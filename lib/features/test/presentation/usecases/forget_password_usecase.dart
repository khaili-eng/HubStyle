import 'package:untitled7/features/test/repo/auth_repository.dart';

class ForgetPasswordUseCase{
  final AuthRepository repo;
  ForgetPasswordUseCase(this.repo);
  Future<void> call(String email){
    return repo.forgetPassword(email);
  }
}