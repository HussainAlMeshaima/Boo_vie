import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  FirebaseAuth _firebaseAuthInstance = FirebaseAuth.instance;
  User _user = FirebaseAuth.instance.currentUser;

  Future<bool> hasUser() async {
    return _firebaseAuthInstance?.currentUser != null;
  }

  Future<String> userId() async {
    return _firebaseAuthInstance.currentUser.uid;
  }

  Future<String> userDisplayName() async {
    return _firebaseAuthInstance.currentUser.displayName;
  }

  Future<String> userEmail() async {
    return _firebaseAuthInstance.currentUser.email;
  }

  Future<String> userphotoURL() async {
    return _firebaseAuthInstance.currentUser.photoURL;
  }

  Future<UserCredential> signInAnonymously() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInAnonymously();
    return userCredential;
  }

  Future<String> createUserWithEmailAndPassword(
      String userEmail, String userPassword) async {
    String _string;

    if (userEmail == null || userEmail == '') {
      return 'Please input an email';
    }
    if (userPassword == null || userPassword == '') {
      return 'Please input a password';
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: userEmail, password: userPassword);
      _string = 'User has been created successfully';
    } on FirebaseAuthException catch (exception) {
      _string = getErrorMessageFromFirebaseException(exception);
    } catch (e) {
      print(e);
    }
    return _string;
  }

  Future<String> signInWithEmailAndPassword(
      String userEmail, String userPassword) async {
    String _string;

    if (userEmail == null || userEmail == '') {
      return 'Please input an email';
    }
    if (userPassword == null || userPassword == '') {
      return 'Please input a password';
    }
    try {
      await _firebaseAuthInstance.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);
      _string = 'User Has Logged In';
    } on FirebaseAuthException catch (exception) {
      _string = getErrorMessageFromFirebaseException(exception);
    }
    return _string;
  }

  void sendEmailVerification() async {
    if (!_user.emailVerified) {
      await _user.sendEmailVerification();
    }
  }

  Future<String> sendResetPasswordLink(String userEmail) async {
    String _string;
    if (userEmail == null || userEmail == '') {
      return 'Please input an email';
    }
    try {
      await _firebaseAuthInstance.sendPasswordResetEmail(email: userEmail);
      _string =
          'An email has been sent to $userEmail with reset password link.';
    } catch (e) {
      _string = 'Could not send email with reset password link. $e';
    }
    return _string;
  }

  Future<String> signOut() async {
    await FirebaseAuth.instance.signOut();
    return 'User has sign out successfully';
  }

  Future<String> deleteUser() async {
    String _string;
    try {
      await FirebaseAuth.instance.currentUser.delete();

      _string = 'User has been successfully deleted';
    } on FirebaseAuthException catch (exception) {
      _string = getErrorMessageFromFirebaseException(exception);
    }
    return _string;
  }

  String getErrorMessageFromFirebaseException(FirebaseAuthException exception) {
    switch (exception.code.toLowerCase()) {
      case 'email-already-in-use':
        return 'An account already exists for the email you\'re trying to use. Login instead.';
      case 'invalid-email':
        return 'The email you\'re using is invalid. Please use a valid email.';
      case 'operation-not-allowed':
        return 'The authentication is not enabled on Firebase. Please enable the Authentitcation type on Firebase';
      case 'weak-password':
        return 'Your password is too weak. Please use a stronger password.';
      case 'wrong-password':
        return 'You seemed to have entered the wrong password. Double check it and try again.';
      case 'requires-recent-login':
        return 'The user must reauthenticate before this operation can be executed.';
      default:
        return exception.message ??
            'Something went wrong on our side. Please try again';
    }
  }
}
