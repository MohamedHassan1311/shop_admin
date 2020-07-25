import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;
  final auth = PhoneAuthProvider.providerId;

  Future<String> signUp(String email, String password, name) async {
    final authResult = await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .timeout(Duration(seconds: 20));
    await updateUserName(name, authResult.user);

    return authResult.user.uid;
  }

  Future updateUserName(String name, FirebaseUser currentUser) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
  }

  Future<AuthResult> signIn(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  logout() async {
    await _auth.signOut();
  }
}
