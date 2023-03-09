import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? username;
  String? email;
  String? password;
  String? photoUrl;
  String? id;
  Timestamp? signedUpAt;

  UserModel(
      {this.username,
      this.email,
      this.password,
      this.id,
      this.photoUrl,
      this.signedUpAt,
   });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    password = json['password'];
    photoUrl = json['photoUrl'];
    signedUpAt = json['signedUpAt'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['email'] = email;
    data['password'] = password;
    data['photoUrl'] = photoUrl;
    data['signedUpAt'] = signedUpAt;
    data['id'] = id;

    return data;
  }
}
