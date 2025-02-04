import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? displayName;
  String? photoUrl;
  DateTime? createdTime;
  String? phoneNumber;
  String? password;

  UserModel({
    this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.createdTime,
    this.phoneNumber,
    this.password,
  });


  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    //Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: snapshot.id,
      email: snapshot['email'],
      displayName: snapshot['displayName'],
      photoUrl: snapshot['photoUrl'],
      createdTime: snapshot['createdTime'].toDate(),
      phoneNumber: snapshot['phoneNumber'],
      password: snapshot['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'createdTime': createdTime,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}