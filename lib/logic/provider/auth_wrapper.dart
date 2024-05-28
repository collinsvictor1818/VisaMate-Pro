// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AuthenticationWrapper extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final authState = watch(userProvider);

//     return authState.when(
//       data: (user) {
//         if (user == null) {
//           return LogInUser();
//         } else {
//           return MobileScaffold();
//         }
//       },
//       loading: () => CircularProgressIndicator(color: Theme.of(context).colorScheme.tertiary),
//       error: (error, stackTrace) => Center(child: Text('Error: $error')),
//     );
//   }
// }
