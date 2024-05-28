// import 'package:flutter/material.dart';

// class SignInPage extends StatelessWidget {
//   final AuthService _authService = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign In'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 User? user = await _authService.signInWithGoogle();
//                 if (user != null) {
//                   _showUserProfile(context, user);
//                 }
//               },
//               child: Text('Sign in with Google'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 User? user = await _authService.signInWithFacebook();
//                 if (user != null) {
//                   _showUserProfile(context, user);
//                 }
//               },
//               child: Text('Sign in with Facebook'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 User? user = await _authService.signInWithTwitter();
//                 if (user != null) {
//                   _showUserProfile(context, user);
//                 }
//               },
//               child: Text('Sign in with Twitter'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showUserProfile(BuildContext context, User user) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => UserProfilePage(user: user),
//       ),
//     );
//   }
// }

// class UserProfilePage extends StatelessWidget {
//   final User user;

//   UserProfilePage({required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Profile'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Name: ${user.displayName}'),
//             Text('Email: ${user.email}'),
//             Text('Phone: ${user.phoneNumber ?? 'Not Provided'}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
