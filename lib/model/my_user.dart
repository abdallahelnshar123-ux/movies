class MyUser {
  static const String collectionName = 'Users';
  String name;
  String email;
  String id;
  String phone;
  int avatarIndex;



  MyUser({required this.id , required this.email ,  required this.name, required this.phone, required this.avatarIndex});

  ///json => object
  MyUser.fromFireStore(Map<String,dynamic>data):this(
    id:data['id']as String,
    name: data['name']as String,
    email:data['email'] as String,
    phone:data['phone'] as String,
    avatarIndex:data['avatarIndex']
  );

  ///object => jason
  Map<String,dynamic> toFireStore(){
    return {
      'id' : id,
      'name' : name,
      'email' : email,
      'phone' : phone,
      'avatarIndex':avatarIndex
    };
  }
}