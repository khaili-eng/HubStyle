import 'package:untitled7/features/test/repo/auth_repository.dart';

class RegisterUseCase{
  final AuthRepository repo;
  RegisterUseCase(this.repo);
  Future<void> call(String fullName,String email,String address,String password){
    return repo.register(fullName, email, address, password);
  }
}