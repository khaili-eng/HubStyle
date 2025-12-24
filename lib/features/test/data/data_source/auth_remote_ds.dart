class AuthRemoteDataSource{
  Future<String> login(String password,String email) async{
    await Future.delayed(const Duration(seconds: 1));
    return "fake_token";
  }
  Future<void> register(String fullName,String email,String address,String password)async{
    await Future.delayed(const Duration(seconds: 1));
  }
  Future<void> forgetPassword(String email)async{
    await Future.delayed(const Duration(seconds: 1));

  }
  Future<bool> verifyCode(String code)async{
    await Future.delayed(const Duration(milliseconds: 500));
    return code == "1234";
  }
}