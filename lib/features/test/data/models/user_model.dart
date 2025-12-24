class UserModel{
  final String fullName;
  final String email;
  final String address;
  final String password;
  final String avatarUrl;
  UserModel({
    required this.fullName,
    required this.email,
    required this.address,
    required this.password,
    required this.avatarUrl});

  //to json
  Map<String,dynamic> toJson()=>{
    'fullName':fullName,
    'email':email,
    'address':address,
    'password':password,
    'avatarUrl':avatarUrl,
  };
  //from json
factory UserModel.fromJson(Map<String,dynamic>json) => UserModel(
    fullName: json['fullName']??'',
    email: json['email']??'',
    address: json['address']??'',
    password: json['password']??'',
    avatarUrl: json['avatarUrl']??''

);
  factory UserModel.defaultUser() {
    return  UserModel(
      fullName: 'khalil darwish ',
      email: 'khalildarwish@gmail.com',
      address: 'Tartous,Safita',
      password: '12341234',
      avatarUrl: 'https://via.placeholder.com/150/007ACC/FFFFFF?text=MI',
    );
  }
}