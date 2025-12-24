abstract class AuthRepository{
  Future<String>login(String password,String email);
  Future<void>register(String fullName,String email,String address,String password);
  Future<void>forgetPassword(String email);
  Future<bool>verifyCode(String code);
}