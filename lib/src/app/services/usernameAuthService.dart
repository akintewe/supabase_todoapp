import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserNameAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _userDatabase =
      FirebaseDatabase.instance.reference().child('users');

  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Generate a unique user ID (UID) for the registered user
      String userId = result.user?.uid ?? '';

      // Store the user ID in the 'users' database under the user's email
      await _userDatabase.child(userId).set({'email': email});

      return result.user;
    } catch (e) {
      print('Error registering user: $e');
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
    String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user;
    } catch (e) {
      print('Error signing in: $e');
      return null;
    }
  }
}
