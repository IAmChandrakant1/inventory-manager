import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';
import '../routes/routes.dart';
import '../utils/log_print.dart';
import '../view/login_screen.dart';

class AuthServices extends GetxService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseStorage storage = FirebaseStorage.instance;
  OAuthCredential? facebookAuthCredential;

  get user => auth.currentUser;

  get userID => auth.currentUser?.uid;

  get userEmail => auth.currentUser?.email;

  get userProfileUrl => auth.currentUser?.photoURL;

  SharedPreferences? prefs;

  var userModel = UserModel().obs;

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> setLoggedIn(bool value) async {
    await prefs!.setBool('isLoggedIn', value);
  }

  bool isLoggedIn() {
    print('isLoggedIn called');
    return prefs!.getBool('isLoggedIn') ?? false;
  }

  Future<UserCredential?> signInWithGoogle() async {
    print('signInWithGoogle called');
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
    await googleUser!.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken, idToken: googleAuth.idToken);
    try {
      UserCredential firebaseUser =
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (firebaseUser != null) {
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: firebaseUser.user!.uid)
            .get();
      }

      UserModel user = UserModel(
        uid: auth.currentUser!.uid,
        email: auth.currentUser!.email ?? '',
        password: '',
        photoUrl: auth.currentUser!.photoURL ?? '',
        phoneNumber: auth.currentUser!.phoneNumber ?? '',
        displayName: auth.currentUser!.displayName ?? '',
        createdTime: DateTime.now(),
      );

      //await storeUserInfo(user.email!, '', user.photoUrl!, user.phoneNumber!, user.displayName!);
      setLoggedIn(true);
      Get.toNamed(Routes.dashboard);
      return firebaseUser;
    } catch (exe) {
      logPrint('exe: ${exe}');
    }
    return null;
  }

  Future signUp({required String email, required String password}) async {
    logPrint('signUp called');
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //await storeUserInfo(email, password, '', '', '');
      await user.user!.sendEmailVerification();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future signIn({required String email, required String password}) async {
    logPrint('signIn called');
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //await storeUserInfo(email, password, '', '', '');
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future resetPassword({required String email}) async {
    logPrint('resetPassword called');
    try {
      await auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    await prefs!.remove('isLoggedIn');
    //update();
    Get.offAll(const LoginScreen());
  }

  // Future<void> storeUserInfo(String email, String password, String photo, String phoneNo, String displayName) async {
  //   var playlists = await DBProvider.instance.getAllPlaylists();
  //   var uid = auth.currentUser?.uid ?? '';
  //
  //   List<String> playlistID = playlists.map((data) => data.id as String).toList();
  //   List<String> userID = playlists.map((data) => data.userID as String).toList();
  //   print('playlistID: $playlistID');
  //   print('userID: $userID');
  //
  //   List<String> newPlaylistID = playlistID.where((id) {
  //     int index = playlistID.indexOf(id);
  //     return userID[index] == uid;
  //   }).toList();
  //
  //   print('newPlaylistID: $newPlaylistID');
  //
  //   userModel.value = UserModel(
  //     uid: uid,
  //     email: email ?? '',
  //     password: password ?? '',
  //     photoUrl: auth.currentUser?.photoURL ?? '',
  //     phoneNumber: auth.currentUser?.phoneNumber ?? '',
  //     displayName: auth.currentUser?.displayName ?? '',
  //     playlistID: newPlaylistID,
  //     createdTime: DateTime.now(),
  //   );
  //   await firestore
  //       .collection('users')
  //       .doc('${user.uid}')
  //       .set(userModel.value.toMap());
  // }

  Future<UserModel?> getUserData(String uid) async {
    if(userModel.value.uid !=null){
      return userModel.value;
    }
    DocumentSnapshot snapshot = await firestore.collection('users').doc(uid).get();
    if (snapshot.exists) {
      userModel.value = UserModel.fromSnapshot(snapshot);
      return userModel.value;
    } else {
      return null;
    }
  }

  Future<AuthServices> init() async {
    return this;
  }

}