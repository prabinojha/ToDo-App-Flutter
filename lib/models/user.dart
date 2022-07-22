class UserModel {
  String? uid;
  String? email;
  String? name;
  bool? isPremium;

  UserModel({
    this.uid,
    this.email,
    this.name,
    this.isPremium,
  });

  // receiving data from the server and mapping into into our own fields
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
    };
  }
}
