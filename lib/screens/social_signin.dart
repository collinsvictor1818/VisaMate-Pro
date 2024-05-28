
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:twitter_login/twitter_login.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Google Sign-In
//   Future<User?> signInWithGoogle() async {
//     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//     if (googleUser == null) {
//       return null;
//     }
//     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//     final OAuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     UserCredential userCredential = await _auth.signInWithCredential(credential);
//     return userCredential.user;
//   }

//   // Facebook Sign-In
//   Future<User?> signInWithFacebook() async {
//     final LoginResult result = await FacebookAuth.instance.login();
//     if (result.status == LoginStatus.success) {
//       final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//       return userCredential.user;
//     }
//     return null;
//   }

//   // Twitter Sign-In
//   Future<User?> signInWithTwitter() async {
//     final twitterLogin = TwitterLogin(
//       apiKey: 'YOUR_TWITTER_API_KEY',
//       apiSecretKey: 'YOUR_TWITTER_API_SECRET_KEY',
//       redirectURI: 'YOUR_APP_REDIRECT_URI',
//     );
//     final authResult = await twitterLogin.login();
//     if (authResult.status == TwitterLoginStatus.loggedIn) {
//       final session = authResult.authToken!;
//       final OAuthCredential credential = TwitterAuthProvider.credential(
//         accessToken: session.token!,
//         secret: session.secret!,
//       );
//       UserCredential userCredential = await _auth.signInWithCredential(credential);
//       return userCredential.user;
//     }
//     return null;
//   }
// }
